import 'dart:async';
import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/progress/api/InProgressAnimeOrRealCollection.dart';
import 'package:munin/models/bangumi/progress/api/InProgressBookCollection.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubject.dart';
import 'package:munin/models/bangumi/progress/common/InProgressSubjectInfo.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/progress/ProgressActions.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
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

class ProgressBody extends StatefulWidget {
  final OneMuninBar oneMuninBar;
  final BuiltSet<SubjectType> subjectTypes;

  const ProgressBody(
      {Key key, @required this.oneMuninBar, @required this.subjectTypes})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgressBodyState();
  }
}

class _ProgressBodyState extends State<ProgressBody> {
  GlobalKey<MuninRefreshState> _muninRefreshKey =
      GlobalKey<MuninRefreshState>();

  _buildEmptyProgressPageWidget() {
    String requestSubjectTypes =
        widget.subjectTypes.map((type) => type.chineseName).join(',');
    return Column(
      children: <Widget>[
        Text('没有找到在看的$requestSubjectTypes'),
        Text('1. 您没有任何在看的$requestSubjectTypes'),
        Text('2. 应用或bangumi出错，下拉可重试'),
        FlatButton(
          child: Text('查看网页版'),
          onPressed: () {
            return launch(bangumiHomePageUrl, forceSafariVC: true);
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
        bool progressesLoaded = vm.progressesSelector().isPresent;
        BuiltList<InProgressSubject> subjects = progressesLoaded
            ? vm.progressesSelector().value
            : BuiltList<InProgressSubject>();

        List<Widget> widgets = [];

        for (InProgressSubject subject in subjects) {
          Widget widget;
          if (subject is InProgressAnimeOrRealCollection) {
            widget = InProgressAnimeOrRealWidget(
              subject: subject,
              onUpdateSingleEpisode: (EpisodeUpdateType episodeUpdateType,
                  int episodeId, double newEpisodeNumber) {
                vm.updateAnimeOrRealSingleEpisode(
                  context: context,
                  episodeId: episodeId,
                  newEpisodeNumber: newEpisodeNumber,
                  episodeUpdateType: episodeUpdateType,
                  subject: subject.subject,
                );
              },
              onUpdateBatchEpisodes: (int episodeSequentialNumber) {
                vm.updateAnimeOrRealBatchEpisodes(
                  context: context,
                  subject: subject.subject,
                  episodeSequentialNumber: episodeSequentialNumber,
                );
              },
            );
          } else if (subject is InProgressBookCollection) {
            widget = InProgressBookWidget(
              subject: subject,
              onUpdateBookProgress:
                  (int newEpisodeNumber, int newVolumeNumber) {
                Future<void> future = vm.updateBookProgress(
                  context: context,
                  newEpisodeNumber: newEpisodeNumber,
                  newVolumeNumber: newVolumeNumber,
                  subject: subject.subject,
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

          /// padding is handled by ExpansionTile
          itemPadding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return widgets[index];
          },
          onLoadMore: null,
          refreshWidgetStyle: RefreshWidgetStyle.Adaptive,
          itemCount: widgets.length,
          appBar: widget.oneMuninBar,

          /// all progress subjects will be loaded in once, hence no more items
          /// to load if progresses are laoded
          noMoreItemsToLoad: progressesLoaded,
          emptyAfterRefreshWidget: _buildEmptyProgressPageWidget(),
        );
      },
    );
  }
}

class _ViewModel {
  final Optional<BuiltList<InProgressSubject>> Function() progressesSelector;
  final LoadingStatus getProgressLoadingStatus;
  final Future Function(BuildContext context) getProgress;
  final UpdateAnimeOrRealSingleEpisode updateAnimeOrRealSingleEpisode;
  final UpdateAnimeOrRealBatchEpisodes updateAnimeOrRealBatchEpisodes;
  final UpdateBookProgress updateBookProgress;

  factory _ViewModel.fromStore(
      Store<AppState> store, BuiltSet<SubjectType> types) {
    Future _getProgress(BuildContext context) {
      final action = GetProgressAction(context: context, subjectTypes: types);
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
      final action = UpdateAnimeOrRealSingleEpisodeAction(
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
      final action = UpdateAnimeOrRealBatchEpisodesAction(
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

    Optional<BuiltList<InProgressSubject>> _progressesSelector() {
      BuiltMap<SubjectType, BuiltList<InProgressSubject>> progressesInStore =
          store.state.progressState.progresses;
      BuiltList<InProgressSubject> progresses = BuiltList<InProgressSubject>();

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
        getProgressLoadingStatus: null,
        getProgress: _getProgress,
        progressesSelector: _progressesSelector,
        updateAnimeOrRealSingleEpisode: _updateAnimeOrRealSingleEpisode,
        updateAnimeOrRealBatchEpisodes: _updateAnimeOrRealBatchEpisodes,
        updateBookProgress: _updateBookProgress);
  }

  _ViewModel({
    @required this.progressesSelector,
    @required this.getProgressLoadingStatus,
    @required this.getProgress,
    @required this.updateAnimeOrRealSingleEpisode,
    @required this.updateAnimeOrRealBatchEpisodes,
    @required this.updateBookProgress,
  });
}
