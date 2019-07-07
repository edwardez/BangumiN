import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/user/UserProfile.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsRequest.dart';
import 'package:munin/models/bangumi/user/collection/full/ListUserCollectionsResponse.dart';
import 'package:munin/models/bangumi/user/collection/full/OrderCollectionBy.dart';
import 'package:munin/models/bangumi/user/collection/full/UserCollectionTag.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/user/UserActions.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/avatar/CachedCircleAvatar.dart';
import 'package:munin/widgets/shared/bottomsheet/showMinHeightModalBottomSheet.dart';
import 'package:munin/widgets/shared/chips/FilterChipsGroup.dart';
import 'package:munin/widgets/shared/common/Divider.dart';
import 'package:munin/widgets/shared/common/MuninPadding.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:munin/widgets/shared/text/MuninTextSpans.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:munin/widgets/user/collections/CollectionOnUserListWidget.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

class UserCollectionsListWidget extends StatefulWidget {
  final ListUserCollectionsRequest request;

  const UserCollectionsListWidget({
    Key key,
    @required this.request,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserCollectionsListWidgetState();
  }
}

class _UserCollectionsListWidgetState extends State<UserCollectionsListWidget> {
  static const tagsFilterMaxLines = 3;

  static const List<CollectionStatus> validCollectionStatus = [
    CollectionStatus.Wish,
    CollectionStatus.Completed,
    CollectionStatus.InProgress,
    CollectionStatus.OnHold,
    CollectionStatus.Dropped,
  ];

  GlobalKey<MuninRefreshState> _muninRefreshKey =
      GlobalKey<MuninRefreshState>();

  ListUserCollectionsRequest currentRequest;

  @override
  void initState() {
    super.initState();
    currentRequest = widget.request;
  }

  Widget appBarTitle(UserProfile user) {
    if (user == null) {
      return Container();
    }

    final actionName = CollectionStatus.chineseNameWithSubjectType(
        currentRequest.collectionStatus, currentRequest.subjectType);

    return Row(
      children: <Widget>[
        CachedCircleAvatar(
          imageUrl: user.basicInfo.avatar.medium,
        ),
        Padding(
          padding: EdgeInsets.only(left: smallOffset),
        ),
        WrappableText('${user.basicInfo.nickname}$actionName'
            '的${currentRequest.subjectType.chineseName}',
          textStyle: Theme
              .of(context)
              .textTheme
              .body2,
        )
      ],
    );
  }

  String collectionCountByStatus(UserProfile user, CollectionStatus status) {
    final collectionsOnProfilePage =
        user.collectionPreviews[currentRequest.subjectType];
    if (collectionsOnProfilePage == null) {
      return '0';
    }

    int count = collectionsOnProfilePage.collectionDistribution[status] ?? 0;

    return count.toString();
  }

  Optional<String> get maybeCurrentTagName {
    return currentRequest.filterTag == null
        ? Optional.absent()
        : Optional.of(': ${currentRequest.filterTag}');
  }

  Widget buildSortBy(
    BuildContext context,
    ListUserCollectionsResponse collectionsResponse,
  ) {
    return MuninPadding.noVerticalOffset(
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Flexible(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(OMIcons.sort),
                    WrappableText(
                        '${currentRequest.orderCollectionBy.chineseName}'),
                  ],
                ),
                onTap: () {
                  onSelectSortWidget(context);
                },
              ),
              flex: 1,
              fit: FlexFit.tight,
            ),
            VerticalDivider(),
            Flexible(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(OMIcons.filterList),
                    WrappableText(
                      '标签${maybeCurrentTagName.or('')}',
                      maxLines: tagsFilterMaxLines,
                    ),
                  ],
                ),
                onTap: collectionsResponse == null
                    ? null
                    : () {
                        onSelectTag(
                          context,
                          collectionsResponse,
                        );
                      },
              ),
              flex: 1,
              fit: FlexFit.tight,
            ),
          ],
        ),
      ),
    );
  }

  void onSelectSortWidget(BuildContext context) {
    showMinHeightModalBottomSheet(context, [
      for (var orderBy in OrderCollectionBy.values)
        ListTile(
          title: Text(orderBy.chineseName),
          subtitle: Text(orderBy.chineseSortExplanation),
          onTap: () {
            currentRequest =
                currentRequest.rebuild((b) => b..orderCollectionBy = orderBy);
            _muninRefreshKey.currentState.callOnLoadMore();
            Navigator.pop(context);
          },
        )
    ]);
  }

  void onSelectTag(
      BuildContext context, ListUserCollectionsResponse collectionsResponse) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          Widget _buildTags() {
            if (collectionsResponse.userCollectionTagsToList.isEmpty) {
              return MuninPadding(
                  child:
                      Text('暂时没有此分类下的标签', style: defaultCaptionText(context)));
            }

            /// TODO: improve performance if user has a lot of tags.
            return Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: defaultDensePortraitHorizontalOffset),
              children: <Widget>[
                FilterChipsGroup<UserCollectionTag>(
                  chipsLayout: ChipsLayout.Wrap,
                  selectedChip: collectionsResponse
                      .userCollectionTags[currentRequest.filterTag],
                  filterChips: collectionsResponse.userCollectionTagsToList,
                  chipLabelBuilder: (tag) {
                    return MuninTextSpans(
                      children: [
                        MuninTextSpanConfig(tag.name),
                        MuninTextSpanConfig(
                          ' ${tag.taggedSubjectsCount}',
                          defaultCaptionText(context),
                        ),
                      ],
                    );
                  },
                  onChipSelected: (tag) {
                    setState(() {
                      currentRequest = currentRequest
                          .rebuild((b) => b..filterTag = tag.name);
                      _muninRefreshKey.currentState.callOnLoadMore();
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ));
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTags(),
              onePixelHeightDivider(),
              ListTile(
                title: Center(child: Text('重置标签筛选')),
                onTap: () {
                  currentRequest =
                      currentRequest.rebuild((b) => b..filterTag = null);
                  _muninRefreshKey.currentState.callOnLoadMore();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Function _generateOnRefreshCallback(_ViewModel vm) {
    // Don't allow refresh is response is not ready yet.
    if (vm.collectionsResponse == null) {
      return null;
    }

    return () =>
        vm.listUserCollections(
          currentRequest,
          listOlderCollections: false,
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
            title: appBarTitle(vm.user),
            pinned: true,
          ),
          topWidgets: <Widget>[
            FilterChipsGroup<CollectionStatus>(
              initialLeftOffset: defaultDensePortraitHorizontalOffset,
              selectedChip: currentRequest.collectionStatus,
              filterChips: validCollectionStatus,
              chipLabelBuilder: (status) {
                return MuninTextSpans(
                  children: [
                    MuninTextSpanConfig(
                      CollectionStatus.chineseNameWithSubjectType(
                          status, currentRequest.subjectType),
                    ),
                    if (vm.user != null)
                      MuninTextSpanConfig(
                        ' ${collectionCountByStatus(vm.user, status)}',
                        defaultCaptionText(context),
                      ),
                  ],
                );
              },
              onChipSelected: (status) {
                setState(() {
                  // clears tag if status has changed
                  // as tag is per [CollectionStatus]
                  final newFilterTag = status == currentRequest.collectionStatus
                      ? currentRequest.filterTag
                      : null;
                  currentRequest = currentRequest.rebuild((b) => b
                    ..collectionStatus = status
                    ..filterTag = newFilterTag);
                  _muninRefreshKey.currentState.callOnLoadMore();
                });
              },
            ),
            buildSortBy(context, vm.collectionsResponse),
            Divider(),
          ],
          onRefresh: _generateOnRefreshCallback(vm),
          onLoadMore: () {
            return vm.listUserCollections(
              currentRequest,
            );
          },
          noMoreItemsToLoad:
              !(vm.collectionsResponse?.canLoadMoreItems ?? true),
          noMoreItemsWidget: Text(
            '已加载全部收藏',
            style: defaultCaptionText(context),
          ),
          itemCount: vm.collectionsResponse?.collections?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return CollectionOnUserListWidget(
              collection: vm.collectionsResponse.toCollectionsList[index],
              preferredSubjectInfoLanguage: vm.preferredSubjectInfoLanguage,
            );
          },
        );
      },
    );
  }
}

class _ViewModel {
  final ListUserCollectionsRequest request;
  final ListUserCollectionsResponse collectionsResponse;
  final UserProfile user;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  final Future Function(
      ListUserCollectionsRequest externalRequest, {
      bool listOlderCollections,
      }) listUserCollections;

  factory _ViewModel.fromStore(
    Store<AppState> store,
    ListUserCollectionsRequest request,
  ) {
    Future<void> _listUserCollections(
        ListUserCollectionsRequest externalRequest, {
          bool listOlderCollections = true,
        }) {
      final action = ListUserCollectionsRequestAction(
        request: externalRequest,
        listOlderCollections: listOlderCollections,
      );

      store.dispatch(action);

      return action.completer.future;
    }

    return _ViewModel(
      request: request,
      collectionsResponse: store.state.userState.collections[request],
      user: store.state.userState.profiles[request.username],
      preferredSubjectInfoLanguage:
          store.state.settingState.generalSetting.preferredSubjectInfoLanguage,
      listUserCollections: _listUserCollections,
    );
  }

  const _ViewModel({
    @required this.request,
    @required this.collectionsResponse,
    @required this.user,
    @required this.preferredSubjectInfoLanguage,
    @required this.listUserCollections,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          request == other.request &&
          collectionsResponse == other.collectionsResponse &&
          user == other.user &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage;

  @override
  int get hashCode =>
      request.hashCode ^
      collectionsResponse.hashCode ^
      user.hashCode ^
      preferredSubjectInfoLanguage.hashCode;
}
