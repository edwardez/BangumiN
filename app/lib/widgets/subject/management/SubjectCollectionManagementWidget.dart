import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/collection/SubjectCollectionInfo.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/styles/theme/common.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/subject/management/StarRatingFormField.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionIsPrivateFormField.dart';
import 'package:munin/widgets/subject/management/SubjectCollectionStatusFormField.dart';
import 'package:munin/widgets/subject/management/SubjectTagsFormField.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

enum SubjectCollectionError {
  InvalidCollectionStatus,
  LengthyComment,
  TooManyTags
}

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
  final _formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  final tagsController = TextEditingController();

  /// A [SubjectCollectionInfo] that records current form values if [_formKey.currentState.save()] is called
  SubjectCollectionInfo localSubjectCollectionInfo;

  /// A original [SubjectCollectionInfo], it's used to compare whether user has
  /// modified something before exiting, see [_onWillPop]
  SubjectCollectionInfo unmodifiedSubjectCollectionInfo;

  SubjectType subjectType;

  ///Looks like flutter doesn't expose list of current form errors so we maintain
  ///errors ourselves here
  final Map<SubjectCollectionError, String> formErrors = {};

  /// This is the length limitation set by Bangumi and cannot be modified by us
  final int maxCommentLength = 200;

  /// This is the length limitation set by Bangumi and cannot be modified by us
  final int maxTags = 10;

  /// maintains current comment validation status to avoid rebuilding the whole
  /// widget every time user types a comment character
  /// see [_listenToCommentController]
  bool _isCommentFieldValid = true;

  Set<String> currentTags = {};

  LinkedHashMap<String, bool> candidateTags = LinkedHashMap.of({});

  LinkedHashMap<String, bool> headerTags = LinkedHashMap.of({});

  final safeAreaChildHorizontalPadding = defaultPortraitHorizontalPadding;

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

  bool _canSubmitForm() {
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
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (localSubjectCollectionInfo == null) {
      return true;
    }

    _formKey.currentState.save();

    if (unmodifiedSubjectCollectionInfo == localSubjectCollectionInfo ||
        !localSubjectCollectionInfo.isDirtySubjectCollectionInfo()) {
      return true;
    }

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('放弃编辑这份收藏？'),
              content: Text(
                '放弃后输入的信息将不会被保存',
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('放弃编辑'),
                  onPressed: () {
                    Navigator.of(context).pop(
                        true); // Pops the confirmation dialog but not the page.
                  },
                ),
                FlatButton(
                  child: const Text('继续编辑'),
                  onPressed: () {
                    Navigator.of(context).pop(
                        false); // Returning true to _onWillPop will pop again.
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// listen to comment controller, set [_isCommentFieldValid] if form is currently invalid
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
      final Map<SubjectCollectionError, String> formErrors) {
//    assert(formErrors.keys.isNotEmpty);
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

    /// errorMessages shouldn't be empty at this time
    /// in case it happens, show use something
    if (errorMessages.isEmpty) {
      errorMessages.add('神秘错误: app出了点小问题(请考虑向我们汇报此bug)');
    }

    return errorMessages.join('\n');
  }

  void _showDialog(BuildContext context,
      final Map<SubjectCollectionError, String> formErrors) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("请修正以下错误后再提交"),
          content: Text(_buildErrorMessages(formErrors)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
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

  Widget _buildSubjectCollectionStatusFormField() {
    return SubjectCollectionStatusFormField(
      subjectType: subjectType,
      autovalidate: true,
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
      maxLines: 3,
      onSaved: (String comment) {
        localSubjectCollectionInfo =
            localSubjectCollectionInfo.rebuild((b) => b..comment = comment);
      },
    );
  }

  bool prv = false;

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

  _initFormData(Store<AppState> store) {
    if (store.state.subjectState.collections[widget.subjectId] == null) {
      final action = GetCollectionInfoAction(
          context: context, subjectId: widget.subjectId);
      store.dispatch(action);
    }

    BangumiSubject subject =
        store.state.subjectState.subjects[widget.subjectId];

    /// subject should never be null: user must enters this page BEFORE
    /// they enters the subject page
    assert(subject != null);

    if (subject == null) {
      /// in case it's null(exception!), assign a default type
      /// note: [subjectType] only affects action name users see on the ui
      subjectType = SubjectType.Anime;
    } else {
      subjectType = subject.type;
      for (String userSelectedTag in subject.userSelectedTags) {
        candidateTags[userSelectedTag] = true;
        headerTags[userSelectedTag] = true;
      }

      /// suggestedTag might be in current user subject tags, or it might not
      for (String suggestedTag in subject.bangumiSuggestedTags) {
        /// Only if [headerTags] doesn't contain this tag, we need to add it to
        /// [candidateTags]
        if (!headerTags.containsKey(suggestedTag)) {
          candidateTags[suggestedTag] = false;
        }
      }
    }
  }

  _buildSubmitWidget(BuildContext context, _ViewModel vm, int subjectId) {
    if (vm.collectionsSubmissionStatus == LoadingStatus.Loading) {
      return IconButton(
        icon: SizedBox(
          child: CircularProgressIndicator(),
        ),
        onPressed: null,
      );
    }

    return GestureDetector(
      child: FlatButton(
          onPressed: _canSubmitForm()
              ? () {
                  _formKey?.currentState?.save();
                  vm.collectionInfoUpdateRequest(
                      context, subjectId, localSubjectCollectionInfo);
                }
              : null,
          textColor: Theme.of(context).primaryColor,
          child: Text('更新收藏')),
      onTap: _canSubmitForm()
          ? null
          : () {
              _showDialog(context, formErrors);
            },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, widget.subjectId),
      distinct: true,
      onInit: (store) {
        _initFormData(store);
      },
      onDispose: (store) {
        store
            .dispatch(CleanUpCollectionInfoAction(subjectId: widget.subjectId));
      },
      builder: (BuildContext context, _ViewModel vm) {
        int subjectId = widget.subjectId;
        if (vm.subjectCollectionInfo == null) {
          final action =
              GetCollectionInfoAction(context: context, subjectId: subjectId);

          return RequestInProgressIndicatorWidget(
              loadingStatus: vm.collectionLoadingStatus, refreshAction: action);
        }

        /// If it's the first time widget tries to build the form
        /// subjectCollectionInfo will be null, assigning collection info from
        /// vm state
        if (localSubjectCollectionInfo == null) {
          localSubjectCollectionInfo = vm.subjectCollectionInfo;
          unmodifiedSubjectCollectionInfo = localSubjectCollectionInfo;

          /// [commentController] and [initialValue] cannot be both non-null
          /// Since we'are using commentController, initial value should be set
          /// through commentController
          commentController.text = localSubjectCollectionInfo.comment;
        }

        return ScaffoldWithRegularAppBar(
          appBar: AppBar(
            title: Text('作品标题'),
            actions: <Widget>[_buildSubmitWidget(context, vm, subjectId)],
          ),
          safeAreaChild: Form(
            key: _formKey,
            autovalidate: true,
            onWillPop: _onWillPop,
            child: ListView(
              children: <Widget>[
                _buildSubjectCollectionStatusFormField(),
                _buildStarRatingFormField(),
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

class _ViewModel {
  final SubjectCollectionInfo subjectCollectionInfo;
  final LoadingStatus collectionLoadingStatus;
  final LoadingStatus collectionsSubmissionStatus;
  final Function(BuildContext context, int subjectId) getCollectionInfo;
  final Function(BuildContext context, int subjectId,
          SubjectCollectionInfo collectionUpdateRequest)
      collectionInfoUpdateRequest;

  factory _ViewModel.fromStore(Store<AppState> store, int subjectId) {
    _collectionUpdateRequest(BuildContext context, int subjectId,
        SubjectCollectionInfo collectionUpdateRequest) {
      final action = UpdateCollectionRequestAction(
          context: context,
          subjectId: subjectId,
          collectionUpdateRequest: collectionUpdateRequest);
      store.dispatch(action);
    }

    _getCollectionInfo(BuildContext context, int subjectId) {
      final action =
          GetCollectionInfoAction(context: context, subjectId: subjectId);
      store.dispatch(action);
    }

    return _ViewModel(
      collectionInfoUpdateRequest: _collectionUpdateRequest,
      getCollectionInfo: _getCollectionInfo,
      subjectCollectionInfo: store.state.subjectState.collections[subjectId],
      collectionLoadingStatus:
          store.state.subjectState.collectionsLoadingStatus[subjectId],
      collectionsSubmissionStatus:
          store.state.subjectState.collectionsSubmissionStatus[subjectId],
    );
  }

  _ViewModel({
    @required this.getCollectionInfo,
    @required this.collectionInfoUpdateRequest,
    @required this.subjectCollectionInfo,
    @required this.collectionLoadingStatus,
    @required this.collectionsSubmissionStatus,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          collectionLoadingStatus == other.collectionLoadingStatus &&
          collectionsSubmissionStatus == other.collectionsSubmissionStatus &&
          subjectCollectionInfo == other.subjectCollectionInfo;

  @override
  int get hashCode => hash3(collectionLoadingStatus.hashCode,
      collectionsSubmissionStatus.hashCode, subjectCollectionInfo.hashCode);
}
