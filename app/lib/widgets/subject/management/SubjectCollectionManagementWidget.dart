import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/app/AppActions.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/shared/RequestStatus.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/async.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/progress/BookProgressUpdateField.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/shared/dialog/common.dart';
import 'package:munin/widgets/shared/form/SimpleFormSubmitWidget.dart';
import 'package:munin/widgets/shared/refresh/AdaptiveProgressIndicator.dart';
import 'package:munin/widgets/subject/management/StarRatingFormField.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionIsPrivateFormField.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionMoreActions.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionStatusFormField.dart';
import 'package:munin/widgets/subject/management/SubjectTagsFormField.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

enum SubjectCollectionError {
  InvalidCollectionStatus,
  LengthyComment,
  TooManyTags
}

typedef GetCollectionInfo = Future<void> Function(int subjectId);

/// Subject collection management form
/// Note: there is currently a bug in Flutter which will result in unnecessary
/// Haptic feedback, we'll need to wait for https://github.com/flutter/flutter/pull/27900
/// to be merged to release branch
class SubjectCollectionManagementWidget extends StatefulWidget {
  final int subjectId;

  const SubjectCollectionManagementWidget({Key key, this.subjectId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectCollectionManagementWidgetState();
  }
}

class _SubjectCollectionManagementWidgetState
    extends State<SubjectCollectionManagementWidget> {
  /// Length limitation as set by Bangumi, it cannot be modified by Munin.
  static const int maxCommentLength = 200;

  /// Length limitation as set by Bangumi it cannot be modified by Munin.
  static const int maxTags = 10;

  /// Max lines of the comment field, this value is controlled and set by Munin.
  static const commendFieldMaxLines = 10;
  static const commendFieldMinLines = 3;

  final _formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  final tagsController = TextEditingController();
  final episodeEditController = TextEditingController();
  final volumeEditController = TextEditingController();

  /// A [SubjectCollectionInfo] that records current form values if [_formKey.currentState.save()] is called
  SubjectCollectionInfo localSubjectCollectionInfo;

  /// A original [SubjectCollectionInfo], it's used to compare whether user has
  /// modified something before exiting, see [_onDiscardCollectionEdit]
  SubjectCollectionInfo unmodifiedSubjectCollectionInfo;

  /// Whether subject info has been populated to the form. It equals to whether
  /// [_populateSubjectInfoToForm] has been called.
  bool _hasPopulatedSubjectInfo = false;

  ///Looks like flutter doesn't expose list of current form errors so we maintain
  ///errors ourselves here
  final Map<SubjectCollectionError, String> formErrors = {};

  RequestStatus collectionsSubmissionStatus = RequestStatus.Initial;

  /// Maintains current comment validation status to avoid rebuilding the whole
  /// widget every time user types a comment character
  /// see [_listenToCommentController]
  bool _isCommentFieldValid = true;

  Set<String> currentTags = {};

  LinkedHashMap<String, bool> candidateTags = LinkedHashMap.of({});

  LinkedHashMap<String, bool> headerTags = LinkedHashMap.of({});

  final safeAreaChildHorizontalPadding = defaultPortraitHorizontalOffset;

  /// Looks like flutter doesn't have handy validate attribute like what we have in Angular
  /// so every time an extra call to .validate() function is needed
  /// also note that form might not be ready while this attribute is accessed
  /// so null-aware accessor is needed
  bool commentHasError({String comment}) {
    comment ??= commentController.text;
    return comment.length > maxCommentLength;
  }

  bool collectionStatusHasError({CollectionStatus status}) {
    status ??= localSubjectCollectionInfo.status.type;
    return CollectionStatus.isInvalid(status);
  }

  bool get _canSubmitForm {
    return !commentHasError() && !collectionStatusHasError();
  }

  @override
  void initState() {
    super.initState();
    commentController.addListener(_listenToCommentController);
  }

  @override
  void dispose() {
    commentController.dispose();
    tagsController.dispose();
    episodeEditController.dispose();
    volumeEditController.dispose();
    super.dispose();
  }

  /// Checks whether user has modified some data and shows an confirmation
  /// accordingly.
  ///
  /// Currently book progress is not checked: before refactoring this widget
  /// to a smaller one, it might not worth adding another 100-ish lines of code
  /// to check whether this simple value has been modified.
  Future<bool> _onDiscardCollectionEdit() async {
    if (localSubjectCollectionInfo == null) {
      return true;
    }

    _formKey.currentState.save();

    if (unmodifiedSubjectCollectionInfo == localSubjectCollectionInfo ||
        !localSubjectCollectionInfo.isDirtySubjectCollectionInfo()) {
      return true;
    }

    return await showMuninYesNoDialog(context, title: Text('确认放弃编辑这份收藏？'),
      confirmAction: EditorYesNoPrompt.confirmAction,
      cancelAction: EditorYesNoPrompt.cancelAction,) ?? false;
  }

  /// Listens to comment controller, set [_isCommentFieldValid] if form is currently invalid
  /// triggers a rebuild only if comment validation status has changed
  _listenToCommentController() {
    if (!commentHasError(comment: commentController.text)) {
      /// TODO: investigate how to correctly(?) disable submit button
      if (!_isCommentFieldValid) {
        setState(() {
          _isCommentFieldValid = true;
        });
      }
    } else {
      if (_isCommentFieldValid) {
        setState(() {
          _isCommentFieldValid = false;
        });
      }
    }
  }

  String _buildErrorMessages(
    final Map<SubjectCollectionError, String> formErrors,
    subjectType,
  ) {
    assert(formErrors.keys.isNotEmpty);
    List<String> errorMessages = [];
    if (formErrors.containsKey(SubjectCollectionError.LengthyComment)) {
      errorMessages
          .add('评论过长: ${formErrors[SubjectCollectionError.LengthyComment]}');
    }

    if (formErrors.containsKey(SubjectCollectionError.TooManyTags)) {
      errorMessages
          .add('标签过多: ${formErrors[SubjectCollectionError.TooManyTags]}');
    }

    if (formErrors
        .containsKey(SubjectCollectionError.InvalidCollectionStatus)) {
      String activityVerb = subjectType.activityVerbChineseNameByType;
      errorMessages
          .add('收藏状态无效: 请选择一个收藏状态（如：想$activityVerb, $activityVerb过...）');
    }

    // errorMessages shouldn't be empty at this time
    // in case it happens, show use something
    if (errorMessages.isEmpty) {
      errorMessages.add('神秘错误: app出了点小问题(请考虑向我们汇报此bug)');
    }

    return errorMessages.join('\n');
  }

  void _showDialog(
    BuildContext context,
    final Map<SubjectCollectionError, String> formErrors,
    SubjectType subjectType,
  ) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("请修正以下错误后再提交"),
          content: Text(_buildErrorMessages(formErrors, subjectType)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubjectCollectionStatusFormField(SubjectType subjectType) {
    return SubjectCollectionStatusFormField(
      subjectType: subjectType,
      autovalidateMode: AutovalidateMode.always,
      initialStatus: localSubjectCollectionInfo.status.type,
      validator: (CollectionStatus status) {
        if (collectionStatusHasError(status: status)) {
          String invalidStatusMessage = '收藏状态无效';
          formErrors[SubjectCollectionError.InvalidCollectionStatus] =
              invalidStatusMessage;
          return invalidStatusMessage;
        } else {
          formErrors.remove(SubjectCollectionError.InvalidCollectionStatus);
        }
      },
      onSaved: (CollectionStatus status) {
        localSubjectCollectionInfo = localSubjectCollectionInfo
            .rebuild((b) => b..status.update((b) => b..type = status));
      },
      onChipSelected: (CollectionStatus status) {
        /// if chip is selected, rebuild widget to update state of submit button
        setState(() {
          localSubjectCollectionInfo = localSubjectCollectionInfo
              .rebuild((b) => b..status.update((b) => b..type = status));
        });
      },
      isDarkTheme: Theme.of(context).brightness == Brightness.dark,
    );
  }

  Widget _buildStarRatingFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StarRatingFormField(
        horizontalPadding: safeAreaChildHorizontalPadding,
        initialValue: localSubjectCollectionInfo.rating,
        onSaved: (int rating) {
          localSubjectCollectionInfo =
              localSubjectCollectionInfo.rebuild((b) => b..rating = rating);
        },
      ),
    );
  }

  Widget _buildSubjectTagsFormField() {
    return SubjectTagsFormField(
      candidateTags: candidateTags,
      headerTags: headerTags,
      onSaved: (Set<String> tags) {
        localSubjectCollectionInfo =
            localSubjectCollectionInfo.rebuild((b) => b..tags.replace(tags));
      },
    );
  }

  Widget _buildSubjectCommentFormField(BuildContext context) {
    return TextFormField(
      controller: commentController,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: '短评',
        hintText: '最多$maxCommentLength字',
      ),
      validator: (value) {
        if (commentHasError(comment: value)) {
          String lengthyCommentMessage =
              '最多只能输入$maxCommentLength字,当前已输入${value.length}字';
          formErrors[SubjectCollectionError.LengthyComment] =
              lengthyCommentMessage;
          return lengthyCommentMessage;
        } else {
          formErrors.remove(SubjectCollectionError.LengthyComment);
        }
      },
      maxLines: commendFieldMaxLines,
      minLines: commendFieldMinLines,
      onSaved: (String comment) {
        localSubjectCollectionInfo =
            localSubjectCollectionInfo.rebuild((b) => b..comment = comment);
      },
    );
  }

  Widget _buildSubjectCollectionIsPrivateFormField() {
    return SubjectCollectionIsPrivateFormField(
      initialValue: localSubjectCollectionInfo.private == 1 ? true : false,
      onSaved: (bool isPrivate) {
        localSubjectCollectionInfo = localSubjectCollectionInfo
            .rebuild((b) => b..private = isPrivate ? 1 : 0);
      },
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  List<Widget> _buildBookProgressFormFields(BangumiSubject subject) {
    /// Hides this form field if current progress info on bangumi is unknown.
    bool progressInfoUnknown =
        subject.subjectProgressPreview.completedEpisodesCount == null;
    if (subject.subjectProgressPreview.isTankobon ?? false) {
      progressInfoUnknown = progressInfoUnknown &&
          subject.subjectProgressPreview.completedVolumesCount == null;
    }

    if (subject.type != SubjectType.Book || progressInfoUnknown) {
      return [];
    }

    const String pageStorageKeyPrefix = 'collection';

    List<Widget> fields = [
      BookProgressUpdateField(
        fieldType: FieldType.Episode,
        textEditingController: episodeEditController,
        subjectId: subject.id,
        totalEpisodesOrVolumeCount:
            subject.subjectProgressPreview.totalEpisodesCount,
        pageStorageKeyPrefix: pageStorageKeyPrefix,
        onSaved: (episodesCount) {
          if (localSubjectCollectionInfo.completedEpisodesCount != null) {
            localSubjectCollectionInfo =
                localSubjectCollectionInfo.rebuild((b) => b
                  ..completedEpisodesCount = tryParseInt(
                    episodesCount,
                    defaultValue: 0,
                  ));
          }
        },
      ),
      Padding(
        padding: EdgeInsets.only(bottom: mediumOffset),
      ),
      if (subject.subjectProgressPreview.isTankobon ?? false) ...[
        BookProgressUpdateField(
          fieldType: FieldType.Volume,
          textEditingController: volumeEditController,
          subjectId: subject.id,
          totalEpisodesOrVolumeCount:
              subject.subjectProgressPreview.totalVolumesCount,
          pageStorageKeyPrefix: pageStorageKeyPrefix,
          onSaved: (volumesCount) {
            if (localSubjectCollectionInfo.completedEpisodesCount != null) {
              localSubjectCollectionInfo =
                  localSubjectCollectionInfo.rebuild((b) => b
                    ..completedVolumesCount = tryParseInt(
                      volumesCount,
                      defaultValue: 0,
                    ));
            }
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: mediumOffset),
        ),
      ]
    ];

    return fields;
  }

  /// Initializes required data.
  ///
  /// Returns a [Future] that indicates loading status of required data.
  Future<void> _initData(
      int subjectId,
      BangumiSubject subject,
      SubjectCollectionInfo collectionInfo,
      GetCollectionInfo getCollectionInfo) async {
    bool isSubjectAbsent = subject == null;
    bool isCollectionInfoAbsent = collectionInfo == null;
    if (isSubjectAbsent || isCollectionInfoAbsent) {
      return getCollectionInfo(subjectId);
    } else {
      _populateSubjectInfoToForm(subject);
      return immediateFinishCompleter().future;
    }
  }

  _populateSubjectInfoToForm(BangumiSubject loadedSubject) {
    _hasPopulatedSubjectInfo = true;
    // subject should never be null: user must enters this page BEFORE
    // they enters the subject page, or this data will be fetched before this method
    // is called
    assert(loadedSubject != null, 'Subject must not be null');

    if (loadedSubject == null) {
      // in case it's null(exception!), assign a default type
      // note: [subjectType] only affects action name user sees on the ui
      episodeEditController.text = '0';
      volumeEditController.text = '0';
    } else {
      for (String userSelectedTag in loadedSubject.userSelectedTags) {
        candidateTags[userSelectedTag] = true;
        headerTags[userSelectedTag] = true;
      }

      // suggestedTag might be in current user subject tags, or it might not
      for (String suggestedTag in loadedSubject.bangumiSuggestedTags) {
        // Only if [headerTags] doesn't contain this tag, we need to add it to
        // [candidateTags]
        if (!headerTags.containsKey(suggestedTag)) {
          candidateTags[suggestedTag] = false;
        }
      }

      episodeEditController.text = loadedSubject
              .subjectProgressPreview.completedEpisodesCount
              ?.toString() ??
          '0';
      volumeEditController.text = loadedSubject
              .subjectProgressPreview.completedVolumesCount
              ?.toString() ??
          '0';
    }
  }

  _buildSubmitWidget(BuildContext context, _ViewModel vm) {
    if (collectionsSubmissionStatus == RequestStatus.Loading) {
      return AdaptiveProgressIndicator(
        indicatorStyle: IndicatorStyle.Material,
      );
    }

    return GestureDetector(
      child: SimpleFormSubmitWidget(
        loadingStatus: collectionsSubmissionStatus,
        onSubmitPressed: (innerContext) async {
          _formKey?.currentState?.save();

          setState(() {
            collectionsSubmissionStatus = RequestStatus.Loading;
          });

          try {
            await vm.collectionInfoUpdateRequest(
                vm.subject.id, localSubjectCollectionInfo);
            Navigator.of(context).pop(true);
          } catch (error, stack) {
            vm.handleError(context, error, stack);
            if (mounted) {
              setState(() {
                collectionsSubmissionStatus = RequestStatus.UnknownException;
              });
            }
          }
        },
        canSubmit: _canSubmitForm,
        submitButtonText: '更新',
      ),
      onTap: _canSubmitForm
          ? null
          : () {
              _showDialog(context, formErrors, vm.subject.type);
            },
    );
  }

  _buildSubjectCollectionMoreActions(_ViewModel vm) {
    return SubjectCollectionMoreActions(
      subject: vm.subject,
      deleteCollectionCallback: (subject) {
        return vm.deleteCollection(subject);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> requestStatusFuture;

    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, widget.subjectId),
      distinct: true,
      onInit: (store) {
        int id = widget.subjectId;

        GetCollectionInfo callback = (int subjectId) {
          final action = GetCollectionInfoAction(subjectId: subjectId);
          store.dispatch(action);
          return action.completer.future;
        };
        requestStatusFuture = _initData(
            id,
            store.state.subjectState.subjects[id],
            store.state.subjectState.collections[id],
            callback);
      },
      onDispose: (store) {
        store
            .dispatch(CleanUpCollectionInfoAction(subjectId: widget.subjectId));
      },
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.subjectCollectionInfo == null || vm.subject == null) {
          return RequestInProgressIndicatorWidget(
            retryCallback: (_) {
              return _initData(widget.subjectId, vm.subject,
                  vm.subjectCollectionInfo, vm.getCollectionInfo);
            },
            requestStatusFuture: requestStatusFuture,
          );
        }

        if (!_hasPopulatedSubjectInfo) {
          _populateSubjectInfoToForm(vm.subject);
        }

        // If it's the first time widget tries to build the form
        // subjectCollectionInfo will be null, assigning collection info from
        // vm state
        if (localSubjectCollectionInfo == null) {
          localSubjectCollectionInfo = vm.subjectCollectionInfo;
          unmodifiedSubjectCollectionInfo = localSubjectCollectionInfo;

          // [commentController] and [initialValue] cannot be both non-null
          // Since we'are using commentController, initial value should be set
          // through commentController
          commentController.text = localSubjectCollectionInfo.comment;
        }

        return ScaffoldWithRegularAppBar(
          appBar: AppBar(
            title: vm.subject != null
                ? Text(
              preferredNameFromSubjectBase(
                        vm.subject, vm.preferredSubjectInfoLanguage),
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                : Text('-'),
            actions: <Widget>[
              Builder(
                builder: (BuildContext innerContext) {
                  return _buildSubmitWidget(innerContext, vm);
                },
              ),
              if (!CollectionStatus.isInvalid(
                  unmodifiedSubjectCollectionInfo?.status?.type))
                _buildSubjectCollectionMoreActions(vm)
            ],
          ),
          safeAreaChild: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            onWillPop: _onDiscardCollectionEdit,
            child: ListView(
              children: <Widget>[
                _buildSubjectCollectionStatusFormField(vm.subject.type),
                _buildStarRatingFormField(),
                ..._buildBookProgressFormFields(
                  vm.subject,
                ),
                _buildSubjectTagsFormField(),
                _buildSubjectCommentFormField(context),
                _buildSubjectCollectionIsPrivateFormField(),
              ],
            ),
          ),
          safeAreaChildHorizontalPadding: safeAreaChildHorizontalPadding,
        );
      },
    );
  }
}

_retrieveSubjectInStore(Store<AppState> store, int subjectId) {
  return store.state.subjectState.subjects[subjectId];
}

class _ViewModel {
  final SubjectCollectionInfo subjectCollectionInfo;

  /// subject info in store, might be null.
  final BangumiSubject subject;

  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final GetCollectionInfo getCollectionInfo;
  final Future<void> Function(BangumiSubject subject) deleteCollection;
  final Function(int subjectId, SubjectCollectionInfo collectionUpdateRequest)
      collectionInfoUpdateRequest;

  final void Function(BuildContext context, Object error, StackTrace stack)
  handleError;

  factory _ViewModel.fromStore(Store<AppState> store, int subjectId) {
    Future<void> _collectionUpdateRequest(
        int subjectId, SubjectCollectionInfo collectionUpdateRequest) {
      final action = UpdateCollectionRequestAction(
          subjectId: subjectId,
          collectionUpdateRequest: collectionUpdateRequest);
      store.dispatch(action);
      return action.completer.future;
    }

    Future<void> _deleteCollection(BangumiSubject subject) {
      final action = DeleteCollectionRequestAction(subject: subject);
      store.dispatch(action);
      return action.completer.future;
    }

    Future _getCollectionInfo(int subjectId) {
      final action = GetCollectionInfoAction(subjectId: subjectId);
      store.dispatch(action);
      return action.completer.future;
    }

    return _ViewModel(
      collectionInfoUpdateRequest: _collectionUpdateRequest,
      getCollectionInfo: _getCollectionInfo,
      deleteCollection: _deleteCollection,
      subjectCollectionInfo: store.state.subjectState.collections[subjectId],
      preferredSubjectInfoLanguage:
          store.state.settingState.generalSetting.preferredSubjectInfoLanguage,
      subject: _retrieveSubjectInStore(store, subjectId),
      handleError: (BuildContext context, Object error, StackTrace stack) {
        store.dispatch(HandleErrorAction(
          error: error,
          context: context,
          stack: stack,
        ));
      },
    );
  }

  _ViewModel({
    @required this.getCollectionInfo,
    @required this.deleteCollection,
    @required this.preferredSubjectInfoLanguage,
    @required this.collectionInfoUpdateRequest,
    @required this.subjectCollectionInfo,
    @required this.subject,
    @required this.handleError,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          subjectCollectionInfo == other.subjectCollectionInfo &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage &&
          subject == other.subject;

  @override
  int get hashCode =>
      hash3(subject, subjectCollectionInfo, preferredSubjectInfoLanguage);
}
