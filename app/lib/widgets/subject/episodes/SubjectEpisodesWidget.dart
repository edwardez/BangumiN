import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/models/bangumi/collection/CollectionStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeStatus.dart';
import 'package:munin/models/bangumi/progress/common/EpisodeUpdateType.dart';
import 'package:munin/models/bangumi/progress/html/SimpleHtmlBasedEpisode.dart';
import 'package:munin/models/bangumi/progress/html/SubjectEpisodes.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/common/SubjectType.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:munin/redux/progress/ProgressActions.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/progress/showEpisodeOptionSheet.dart';
import 'package:munin/widgets/shared/chips/StrokeChip.dart';
import 'package:munin/widgets/shared/common/Divider.dart';
import 'package:munin/widgets/shared/common/RequestInProgressIndicatorWidget.dart';
import 'package:munin/widgets/shared/common/ScrollViewWithSliverAppBar.dart';
import 'package:munin/widgets/shared/text/MuninTextSpans.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';
import 'package:quiver/core.dart';
import 'package:quiver/strings.dart';
import 'package:quiver/time.dart';
import 'package:redux/redux.dart';

typedef UpdateSingleSubjectEpisode = Function({
  @required BuildContext context,
  @required int subjectId,
  @required int episodeId,
  @required EpisodeUpdateType episodeUpdateType,
});

typedef UpdateBatchSubjectEpisodes = Function({
  @required BuildContext context,
  @required int subjectId,
  @required int episodeId,
});

class SubjectEpisodesWidget extends StatelessWidget {
  static const episodeTitleMaxLines = 2;
  static const episodeSubtitleAndInfoMaxLines = 3;

  final int subjectId;

  const SubjectEpisodesWidget({Key key, @required this.subjectId})
      : super(key: key);

  Optional<StrokeChip> _buildEpisodeStatusChip(BuildContext context,
      EpisodeStatus status, TextDecoration chipTextDecoration) {
    if (status == EpisodeStatus.Unknown) {
      return Optional.absent();
    }

    Color color = EpisodeStatus.getColor(
      context,
      status,
    );

    return Optional.of(StrokeChip(
      label: Text(
        status.chineseName,
        style: Theme.of(context).textTheme.body1.copyWith(
              color: color,
              decoration: chipTextDecoration,
            ),
      ),
      borderColor: color,
    ));
  }

  static String _secondaryTitleWithEpisodeInfo(
    String secondaryTitle,
    String episodeInfo,
  ) {
    if (isEmpty(secondaryTitle)) {
      return episodeInfo;
    }

    return '$secondaryTitle / $episodeInfo';
  }

  /// Shows an alert dialog that warns user if user wants to modify episode status
  /// of a subject that's not in a valid [CollectionStatus]. The passed-in
  /// [bangumiSubject] might be null.
  ///
  /// See [CollectionStatus.canSafelyModifyEpisodeStatus] for a explanation of
  /// why this dialog is needed.
  Future<bool> _showEpisodeModificationConfirmDialog(
    BuildContext context,
    BangumiSubject bangumiSubject,
  ) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (innerContext) {
        CollectionStatus subjectStatus =
            bangumiSubject?.userSubjectCollectionInfoPreview?.status ??
                CollectionStatus.Unknown;

        SubjectType subjectType = bangumiSubject?.type ?? SubjectType.Unknown;

        String subjectStatusText = CollectionStatus.chineseNameWithSubjectType(
            subjectStatus, subjectType,
            fallbackChineseName: '未收藏');

        String allowedCanModifyEpisodeStatuesText = CollectionStatus
            .allowedCanModifyEpisodeStatues
            .map<String>(
                (status) => CollectionStatus.chineseNameWithSubjectType(
                      status,
                      subjectType,
                    ))
            .join(',');

        TextStyle contentTextStyle = defaultDialogContentTextStyle(context);

        TextStyle boldContentTextStyle =
            contentTextStyle.copyWith(fontWeight: FontWeight.bold);

        return AlertDialog(
          title: Text('确认章节状态修改'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MuninTextSpans(
                children: [
                  MuninTextSpanConfig('你正在尝试修改一个当前收藏状态为', contentTextStyle),
                  MuninTextSpanConfig(subjectStatusText, boldContentTextStyle),
                  MuninTextSpanConfig('的作品的章节状态。\n', contentTextStyle),
                ],
              ),
              MuninTextSpans(
                children: [
                  MuninTextSpanConfig(
                      'Bangumi官方仅明确支持修改作品状态为', contentTextStyle),
                  MuninTextSpanConfig(
                      allowedCanModifyEpisodeStatuesText, boldContentTextStyle),
                  MuninTextSpanConfig('的作品的章节状态。\n', contentTextStyle),
                ],
              ),
              Text('BangumiN可以尝试提交这个修改，但这可能造成预期之外的结果'
                  '（如：章节状态无法正确在网页版上显示）。'),
              Text('是否要继续？'),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('否，取消修改'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            FlatButton(
              child: Text('是'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  _showEpisodeOptionSheet(
    BuildContext context,
    _ViewModel vm,
    SimpleHtmlBasedEpisode episode,
    String secondaryTitleWithEpisodeInfo,
  ) {
    final language = vm.preferredSubjectInfoLanguage;
    showEpisodeOptionSheet(
      context: context,
      episode: episode,
      episodeSubTitle: secondaryTitleWithEpisodeInfo,
      preferredSubjectInfoLanguage: language,
      onUpdateEpisodeOptionTapped: (episodeUpdateType, baseEpisode) async {
        bool canSafelyModifyEpisodeStatus = vm
                .bangumiSubject
                ?.userSubjectCollectionInfoPreview
                ?.status
                ?.canSafelyModifyEpisodeStatus ??
            false;

        if (!canSafelyModifyEpisodeStatus) {
          bool confirmation = await _showEpisodeModificationConfirmDialog(
            context,
            vm.bangumiSubject,
          );
          if (!confirmation) {
            return;
          }
        }

        // Whatever the outcome is, dismisses bottom sheet first.
        Navigator.of(context).pop();

        // Batch update always works.
        if (episodeUpdateType == EpisodeUpdateType.CollectUntil) {
          vm.updateBatchSubjectEpisodes(
            context: context,
            episodeId: baseEpisode.id,
            subjectId: vm.subjectEpisodes.subject.id,
          );
        } else {
          // For single update, if action results the same outcome as
          // current, do nothing.
          if (episodeUpdateType.destinationEpisodeStatus ==
              baseEpisode.userEpisodeStatus) {
            return;
          }
          // Otherwise, update relevant episode.
          vm.updateSingleSubjectEpisode(
            context: context,
            episodeId: baseEpisode.id,
            subjectId: vm.subjectEpisodes.subject.id,
            episodeUpdateType: episodeUpdateType,
          );
        }

        // Reaching the end means request has been sent, showing a snack bar.
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('已发送请求'),
          duration: aSecond,
        ));
      },
    );
  }

  List<Widget> _buildEpisodeWidgets(
    BuildContext context,
    _ViewModel vm,
  ) {
    final language = vm.preferredSubjectInfoLanguage;
    List<Widget> widgets = [];

    if (vm.subjectEpisodes.episodes.isEmpty) {
      widgets.add(Center(
        child: Text(
          '章节列表为空',
          style: defaultCaptionText(context),
        ),
      ));

      return widgets;
    }

    for (var episode in vm.subjectEpisodes.episodes.values) {
      TextDecoration episodeAndStatusTitleDecoration;
      if (episode.userEpisodeStatus == EpisodeStatus.Dropped) {
        // Sets decoration to [TextDecoration.lineThrough] if episode has been
        // dropped by user, otherwise uses null(default value).
        episodeAndStatusTitleDecoration = TextDecoration.lineThrough;
      }

      Widget statusChip = _buildEpisodeStatusChip(
        context,
        episode.userEpisodeStatus,
        episodeAndStatusTitleDecoration,
      ).orNull;

      String secondaryTitle =
          secondaryName(episode.name, episode.chineseName, language).orNull;

      String secondaryTitleWithEpisodeInfo = _secondaryTitleWithEpisodeInfo(
        secondaryTitle,
        episode.episodeInfo,
      );

      Widget episodeWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Row(
              children: <Widget>[
                WrappableText(
                  preferredName(episode.name, episode.chineseName, language),
                  maxLines: episodeTitleMaxLines,
                  fit: FlexFit.tight,
                  textStyle: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(decoration: episodeAndStatusTitleDecoration),
                ),
                if (statusChip != null) statusChip
              ],
            ),
            contentPadding: defaultPortraitHorizontalEdgeInsets,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: defaultPortraitHorizontalOffset,
              right: defaultPortraitHorizontalOffset,
              top: smallOffset,
              bottom: largeOffset,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  secondaryTitleWithEpisodeInfo,
                  overflow: TextOverflow.clip,
                  maxLines: episodeSubtitleAndInfoMaxLines,
                  style: defaultCaptionText(context),
                )
              ],
            ),
          )
        ],
      );
      widgets.add(InkWell(
        child: episodeWidget,
        onTap: () {
          _showEpisodeOptionSheet(
            context,
            vm,
            episode,
            secondaryTitleWithEpisodeInfo,
          );
        },
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> requestStatusFuture;
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store store) => _ViewModel.fromStore(store, subjectId),
      distinct: true,
      onInit: (store) {
        final action = GetSubjectEpisodesRequestAction(subjectId: subjectId);
        store.dispatch(action);
        requestStatusFuture = action.completer.future;
      },
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.subjectEpisodes == null) {
          return RequestInProgressIndicatorWidget(
            retryCallback: (_) => vm.getSubjectEpisodes(),
            requestStatusFuture: requestStatusFuture,
          );
        }

        List<Widget> widgets = _buildEpisodeWidgets(context, vm);

        return ScrollViewWithSliverAppBar(
          appBarMainTitle: Text('章节'),
          nestedScrollViewBody: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: bottomOffset),
            itemBuilder: (BuildContext context, int index) {
              return widgets[index];
            },
            separatorBuilder: (BuildContext context, int index) =>
                onePixelHeightDivider(),
            itemCount: widgets.length,
          ),
          safeAreaChildPadding: EdgeInsets.zero,
          enableBottomSafeArea: false,
        );
      },
    );
  }
}

class _ViewModel {
  /// A full subject instance as stored in react store.
  /// [bangumiSubject] might be null if it doesn't exist in store.
  final BangumiSubject bangumiSubject;
  final SubjectEpisodes subjectEpisodes;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;

  final Future<void> Function() getSubjectEpisodes;
  final UpdateSingleSubjectEpisode updateSingleSubjectEpisode;
  final UpdateBatchSubjectEpisodes updateBatchSubjectEpisodes;

  factory _ViewModel.fromStore(Store<AppState> store, int subjectId) {
    Future<void> _getSubjectEpisodes() {
      final action = GetSubjectEpisodesRequestAction(subjectId: subjectId);
      store.dispatch(action);

      return action.completer.future;
    }

    _updateSingleSubjectEpisode({
      @required BuildContext context,
      @required int subjectId,
      @required int episodeId,
      @required EpisodeUpdateType episodeUpdateType,
    }) {
      final action = UpdateSingleSubjectEpisodeAction(
        context: context,
        subjectId: subjectId,
        episodeUpdateType: episodeUpdateType,
        episodeId: episodeId,
      );
      store.dispatch(action);
    }

    _updateBatchSubjectEpisodes({
      @required BuildContext context,
      @required int subjectId,
      @required int episodeId,
    }) {
      final action = UpdateBatchSubjectEpisodesAction(
        context: context,
        subjectId: subjectId,
        episodeId: episodeId,
      );
      store.dispatch(action);
    }

    return _ViewModel(
      subjectEpisodes: store.state.progressState.watchableSubjects[subjectId],
      getSubjectEpisodes: _getSubjectEpisodes,
      preferredSubjectInfoLanguage:
          store.state.settingState.generalSetting.preferredSubjectInfoLanguage,
      updateSingleSubjectEpisode: _updateSingleSubjectEpisode,
      updateBatchSubjectEpisodes: _updateBatchSubjectEpisodes,
      bangumiSubject: store.state.subjectState.subjects[subjectId],
    );
  }

  const _ViewModel({
    @required this.subjectEpisodes,
    @required this.getSubjectEpisodes,
    @required this.preferredSubjectInfoLanguage,
    @required this.updateSingleSubjectEpisode,
    @required this.updateBatchSubjectEpisodes,
    @required this.bangumiSubject,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          subjectEpisodes == other.subjectEpisodes &&
          preferredSubjectInfoLanguage == other.preferredSubjectInfoLanguage;

  @override
  int get hashCode => hash2(
        subjectEpisodes,
        preferredSubjectInfoLanguage,
      );
}
