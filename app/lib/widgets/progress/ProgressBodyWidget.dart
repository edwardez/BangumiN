import 'dart:async';
import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/api/InProgressBookCollection.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressCollection.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/progress/ProgressActions.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/widgets/progress/InProgressAnimeOrRealWidget.dart';
import 'package:munin/widgets/progress/InProgressBookWidget.dart';
import 'package:munin/widgets/shared/appbar/OneMuninBar.dart';
import 'package:munin/widgets/shared/refresh/MuninRefresh.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

typedef UpdateAnimeOrRealSingleEpisode({
  @required BuildContext context,
  @required int episodeId,
  @required double newEpisodeNumber,
  @required EpisodeUpdateType episodeUpdateType,
  @required InProgressSubjectInfo subject,
});

typedef UpdateAnimeOrRealBatchEpisodes({
  @required BuildContext context,
  @required int episodeSequentialNumber,
  @required InProgressSubjectInfo subject,
});

typedef Future<void> UpdateBookProgress({
  @required BuildContext context,
  @required int newEpisodeNumber,
  @required int newVolumeNumber,
  @required InProgressSubjectInfo subject,
});

class ProgressBodyWidget extends StatefulWidget {
  final OneMuninBar oneMuninBar;
  final BuiltSet<SubjectType> subjectTypes;

  const ProgressBodyWidget(
      {Key key, @required this.oneMuninBar, @required this.subjectTypes})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgressBodyWidgetState();
  }
}

class _ProgressBodyWidgetState extends State<ProgressBodyWidget> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
      GlobalKey<MuninRefreshState>();

  _buildEmptyProgressPageWidget() {
    String requestSubjectTypes =
        widget.subjectTypes.map((type) => type.chineseName).join(',');
    return Column(
      children: <Widget>[
        Text('在看的$requestSubjectTypes列表为空，可能因为：'),
        Text('1. $appOrBangumiHasAnErrorLabel，下拉可重试'),
        Text('2. 目前没有在看的$requestSubjectTypes'),
        FlatButton(
          child: Text(checkWebVersionLabel),
          onPressed: () {
            return launch(bangumiHomePageUrl, forceSafariVC: false);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store store) =>
          _ViewModel.fromStore(store, widget.subjectTypes),
      onInitialBuild: (_ViewModel vm) {
        _muninRefreshKey.currentState?.callOnRefresh();
      },
      builder: (BuildContext context, _ViewModel vm) {
        bool progressesLoaded = vm.collections.isPresent;
        BuiltList<InProgressCollection> collections = progressesLoaded
            ? vm.collections.value
            : BuiltList<InProgressCollection>();

        List<Widget> widgets = [];

        for (InProgressCollection collection in collections) {
          Widget widget;
          if (collection is InProgressAnimeOrRealCollection) {
            widget = InProgressAnimeOrRealWidget(
              collection: collection,
              preferredSubjectInfoLanguage: vm.preferredSubjectInfoLanguage,
              expandAllProgressTiles: vm.expandAllProgressTiles,
              onUpdateSingleEpisode: (EpisodeUpdateType episodeUpdateType,
                  int episodeId, double newEpisodeNumber) {
                vm.updateAnimeOrRealSingleEpisode(
                  context: context,
                  episodeId: episodeId,
                  newEpisodeNumber: newEpisodeNumber,
                  episodeUpdateType: episodeUpdateType,
                  subject: collection.subject,
                );
              },
              onUpdateBatchEpisodes: (int episodeSequentialNumber) {
                vm.updateAnimeOrRealBatchEpisodes(
                  context: context,
                  subject: collection.subject,
                  episodeSequentialNumber: episodeSequentialNumber,
                );
              },
            );
          } else if (collection is InProgressBookCollection) {
            widget = InProgressBookWidget(
              collection: collection,
              preferredSubjectInfoLanguage: vm.preferredSubjectInfoLanguage,
              expandAllProgressTiles: vm.expandAllProgressTiles,
              onUpdateBookProgress:
                  (int newEpisodeNumber, int newVolumeNumber) {
                Future<void> future = vm.updateBookProgress(
                  context: context,
                  newEpisodeNumber: newEpisodeNumber,
                  newVolumeNumber: newVolumeNumber,
                  subject: collection.subject,
                );

                return future;
              },
            );
          } else {}

          if (widget != null) {
            widgets.add(Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: widget,
            ));
          }
        }

        return MuninRefresh(
          key: _muninRefreshKey,
          onRefresh: () {
            return vm.getProgress(context);
          },
          itemBuilder: (BuildContext context, int index) {
            return widgets[index];
          },
          onLoadMore: null,
          refreshWidgetStyle: RefreshWidgetStyle.Adaptive,
          itemCount: widgets.length,
          appBar: widget.oneMuninBar,

          /// all progress subjects will be loaded in once, hence no more items
          /// to load if progresses are loaded
          noMoreItemsToLoad: progressesLoaded,
          emptyAfterRefreshWidget: _buildEmptyProgressPageWidget(),
        );
      },
    );
  }
}

class _ViewModel {
  final Optional<BuiltList<InProgressCollection>> collections;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final bool expandAllProgressTiles;
  final Future Function(BuildContext context) getProgress;
  final UpdateAnimeOrRealSingleEpisode updateAnimeOrRealSingleEpisode;
  final UpdateAnimeOrRealBatchEpisodes updateAnimeOrRealBatchEpisodes;
  final UpdateBookProgress updateBookProgress;

  factory _ViewModel.fromStore(
      Store<AppState> store, BuiltSet<SubjectType> types) {
    Future _getProgress(BuildContext context) {
      final action =
          GetProgressRequestAction(context: context, subjectTypes: types);
      store.dispatch(action);
      return action.completer.future;
    }

    _updateAnimeOrRealSingleEpisode({
      @required BuildContext context,
      @required int episodeId,
      @required EpisodeUpdateType episodeUpdateType,
      @required double newEpisodeNumber,
      @required BuiltSet<SubjectType> subjectTypes,
      @required InProgressSubjectInfo subject,
    }) {
      final action = UpdateInProgressEpisodeAction(
        context: context,
        episodeId: episodeId,
        episodeUpdateType: episodeUpdateType,
        newEpisodeNumber: newEpisodeNumber,
        subject: subject,
      );
      store.dispatch(action);
    }

    _updateAnimeOrRealBatchEpisodes({
      @required BuildContext context,
      @required int episodeSequentialNumber,
      @required BuiltSet<SubjectType> subjectTypes,
      @required InProgressSubjectInfo subject,
    }) {
      final action = UpdateInProgressBatchEpisodesAction(
        context: context,
        newEpisodeNumber: episodeSequentialNumber,
        subject: subject,
      );
      store.dispatch(action);
    }

    Future<void> _updateBookProgress({
      @required BuildContext context,
      @required int subjectId,
      @required int newEpisodeNumber,
      @required int newVolumeNumber,
      @required LinkedHashSet<SubjectType> subjectTypes,
      @required InProgressSubjectInfo subject,
    }) {
      final action = UpdateBookProgressAction(
        context: context,
        newEpisodeNumber: newEpisodeNumber,
        newVolumeNumber: newVolumeNumber,
        subject: subject,
      );
      store.dispatch(action);

      return action.completer.future;
    }

    Optional<BuiltList<InProgressCollection>> _progressesSelector() {
      BuiltMap<SubjectType, BuiltList<InProgressCollection>> progressesInStore =
          store.state.progressState.progresses;
      BuiltList<InProgressCollection> progresses =
          BuiltList<InProgressCollection>();

      for (SubjectType subjectType in types) {
        if (progressesInStore.containsKey(subjectType)) {
          progresses = progresses
              .rebuild((b) => b.addAll(progressesInStore[subjectType]));
        } else {
          return Optional.absent();
        }
      }

      return Optional.of(progresses);
    }

    return _ViewModel(
      getProgress: _getProgress,
      collections: _progressesSelector(),
      preferredSubjectInfoLanguage:
          store.state.settingState.generalSetting.preferredSubjectInfoLanguage,
      expandAllProgressTiles:
          store.state.settingState.generalSetting.expandAllProgressTiles,
      updateAnimeOrRealSingleEpisode: _updateAnimeOrRealSingleEpisode,
      updateAnimeOrRealBatchEpisodes: _updateAnimeOrRealBatchEpisodes,
      updateBookProgress: _updateBookProgress,
    );
  }

  const _ViewModel(
      {@required this.collections,
      @required this.getProgress,
      @required this.updateAnimeOrRealSingleEpisode,
      @required this.updateAnimeOrRealBatchEpisodes,
      @required this.updateBookProgress,
      @required this.preferredSubjectInfoLanguage,
      @required this.expandAllProgressTiles});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          collections == other.collections &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage &&
          expandAllProgressTiles == other.expandAllProgressTiles;

  @override
  int get hashCode =>
      hash3(collections, preferredSubjectInfoLanguage, expandAllProgressTiles);
}
