import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/models/bangumi/subject/review/GetSubjectReviewRequest.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReviewResponse.dart';
import 'package:munin/models/bangumi/subject/review/enum/SubjectReviewMainFilter.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/subject/SubjectActions.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/shared/utils/time/TimeUtils.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/appbar/AppBarTitleForSubject.dart';
import 'package:munin/widgets/shared/chips/FilterChipsGroup.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:munin/widgets/subject/common/SubjectReviewWidget.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class SubjectReviewsWidget extends StatefulWidget {
  final int subjectId;

  final bool showOnlyFriends;

  final SubjectReviewMainFilter mainFilter;

  const SubjectReviewsWidget({
    Key key,
    @required this.subjectId,
    bool showOnlyFriends,
    SubjectReviewMainFilter mainFilter,
  })  : this.showOnlyFriends = showOnlyFriends ?? false,
        this.mainFilter =
            mainFilter ?? SubjectReviewMainFilter.WithNonEmptyComments,
        super(key: key);

  @override
  _SubjectReviewsWidgetState createState() => _SubjectReviewsWidgetState();
}

class _SubjectReviewsWidgetState extends State<SubjectReviewsWidget> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
      GlobalKey<MuninRefreshState>();

  GetSubjectReviewRequest currentRequest;

  @override
  void initState() {
    super.initState();
    currentRequest = GetSubjectReviewRequest(
      (b) => b
        ..subjectId = widget.subjectId
        ..mainFilter = widget.mainFilter
        ..showOnlyFriends = widget.showOnlyFriends,
    );
  }

  /// Builds switch according to current selected [SubjectReviewMainFilter].
  ///
  /// If [SubjectReviewMainFilter] is [SubjectReviewMainFilter.WithNonEmptyComments],
  /// disables the switch and set value to false.
  /// Otherwise, enables the switch and use values in [currentRequest] for switch
  /// value.
  _buildShowOnlyFriendsSwitch(_ViewModel vm) {
    final shouldEnableSwitch = currentRequest.mainFilter !=
        SubjectReviewMainFilter.WithNonEmptyComments;

    var onChanged;
    if (shouldEnableSwitch) {
      onChanged = (bool value) {
        setState(() {
          currentRequest =
              currentRequest.rebuild((b) => b..showOnlyFriends = value);
          _muninRefreshKey.currentState.callOnLoadMore();
        });
      };
    }

    const showOnlyFriendsText = '只看好友';

    final showOnlyFriendsSwitch = SwitchListTile.adaptive(
      onChanged: onChanged,
      value: shouldEnableSwitch ? currentRequest.showOnlyFriends : false,
      title: Text(showOnlyFriendsText),
      activeColor: lightPrimaryDarkAccentColor(context),
    );

    if (shouldEnableSwitch) {
      return showOnlyFriendsSwitch;
    }

    return GestureDetector(
      child: showOnlyFriendsSwitch,
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                content: Text('由于bangumi的限制，'
                    '"${SubjectReviewMainFilter.withNonEmptyCommentsChineseName}"'
                    '和"$showOnlyFriendsText"不能同时使用'),
                actions: <Widget>[
                  FlatButton(
                    child: Text(dialogConfirmation),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
    );
  }

  Widget _buildAppBarTitle(_ViewModel vm) {
    if (vm?.subject == null) {
      return Container();
    }

    return AppBarTitleForSubject(
      coverUrl: vm.subject.cover.common,
      title: preferredNameFromSubjectBase(
          vm.subject, vm.preferredSubjectInfoLanguage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, currentRequest),
      distinct: true,
      onInitialBuild: (vm) {
        _muninRefreshKey.currentState.callOnLoadMore();
      },
      builder: (BuildContext context, _ViewModel vm) {
        return MuninRefresh(
          key: _muninRefreshKey,
          appBar: SliverAppBar(
            title: _buildAppBarTitle(vm),
            pinned: true,
          ),
          topWidgets: <Widget>[
            FilterChipsGroup<SubjectReviewMainFilter>(
              initialLeftOffset: defaultDensePortraitHorizontalOffset,
              selectedChip: currentRequest.mainFilter,
              filterChips: SubjectReviewMainFilter.values.toList(),
              chipNameRetriever: (filter) {
                return filter
                    .chineseName(vm.subject?.type ?? SubjectType.Anime);
              },
              onChipSelected: (filter) {
                setState(() {
                  currentRequest =
                      currentRequest.rebuild((b) => b..mainFilter = filter);
                  _muninRefreshKey.currentState.callOnLoadMore();
                });
              },
            ),
            _buildShowOnlyFriendsSwitch(vm),
          ],
          onRefresh: null,
          onLoadMore: () {
            return vm.getSubjectReviews(
              context,
              currentRequest,
            );
          },
          noMoreItemsToLoad: !(vm.reviews?.canLoadMoreItems ?? true),
          noMoreItemsWidget: Text(
            '已加载全部评价',
            style: defaultCaptionText(context),
          ),
          itemCount: vm.reviews?.items?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return MuninPadding.vertical1xOffset(
              denseHorizontal: true,
              child: SubjectReviewWidget(
                subject: vm.subject,
                review: vm.reviews.items.values.toList()[index],
                timeDisplayFormat: DisplayTimeIn.SwitchByThreshold,
              ),
            );
          },
        );
      },
    );
  }
}

class _ViewModel {
  final GetSubjectReviewRequest request;
  final SubjectReviewResponse reviews;
  final BangumiSubject subject;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  final Future Function(
    BuildContext context,
    GetSubjectReviewRequest externalRequest,
  ) getSubjectReviews;

  factory _ViewModel.fromStore(
      Store<AppState> store, GetSubjectReviewRequest request) {
    Future _getSubjectReviews(
      BuildContext context,
      GetSubjectReviewRequest externalRequest,
    ) {
      final action = GetSubjectReviewAction(
          context: context, getSubjectReviewRequest: externalRequest);

      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(
      reviews: store.state.subjectState.subjectsReviews[request],
      request: request,
      subject: store.state.subjectState.subjects[request.subjectId],
      preferredSubjectInfoLanguage:
          store.state.settingState.generalSetting.preferredSubjectInfoLanguage,
      getSubjectReviews: _getSubjectReviews,
    );
  }

  const _ViewModel({
    @required this.request,
    @required this.subject,
    @required this.reviews,
    @required this.preferredSubjectInfoLanguage,
    @required this.getSubjectReviews,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          request == other.request &&
          reviews == other.reviews &&
          subject == other.subject &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage;

  @override
  int get hashCode =>
      hash4(request, reviews, subject, preferredSubjectInfoLanguage);
}
