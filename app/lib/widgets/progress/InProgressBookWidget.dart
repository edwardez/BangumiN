import 'dart:math' as math;

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/progress/api/InProgressBookCollection.dart';
import 'package:munin/models/bangumi/setting/general/PreferredSubjectInfoLanguage.dart';
import 'package:munin/models/bangumi/timeline/common/BangumiContent.dart';
import 'package:munin/router/routes.dart';
import 'package:munin/shared/utils/bangumi/common.dart';
import 'package:munin/shared/utils/common.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/progress/BookProgressUpdateField.dart';
import 'package:munin/widgets/shared/button/customization.dart';
import 'package:munin/widgets/shared/common/SnackBar.dart';
import 'package:munin/widgets/shared/cover/ClickableCachedRoundedCover.dart';
import 'package:munin/widgets/shared/text/WrappableText.dart';

class InProgressBookWidget extends StatefulWidget {
  final InProgressBookCollection collection;
  final PreferredSubjectInfoLanguage preferredSubjectInfoLanguage;
  final bool expandAllProgressTiles;

  final Future<void> Function(int newEpisodeNumber, int newVolumeNumber)
      onUpdateBookProgress;

  const InProgressBookWidget(
      {Key key,
      @required this.collection,
      @required this.onUpdateBookProgress,
      @required this.preferredSubjectInfoLanguage,
      @required this.expandAllProgressTiles})
      : super(key: key);

  @override
  _InProgressBookWidgetState createState() => _InProgressBookWidgetState();
}

class _InProgressBookWidgetState extends State<InProgressBookWidget> {
  bool updateInProgress = false;
  bool hasTouchedForm = false;
  TextEditingController episodeEditController;
  TextEditingController volumeEditController;

  bool get isDirtyOrTouched {
    return episodeEditController.text !=
            widget.collection.completedEpisodesCount.toString() ||
        volumeEditController.text !=
            widget.collection.completedVolumesCount.toString() ||
        hasTouchedForm;
  }

  @override
  void initState() {
    super.initState();
    episodeEditController = TextEditingController(
        text: widget.collection.completedEpisodesCount.toString());
    episodeEditController.addListener(onEpisodeNumberChange);

    volumeEditController = TextEditingController(
        text: widget.collection.completedVolumesCount.toString());
    volumeEditController.addListener(onVolumeNumberChange);
  }

  @override
  void dispose() {
    episodeEditController.dispose();
    volumeEditController.dispose();
    super.dispose();
  }

  onEpisodeNumberChange() {
    setState(() {
      hasTouchedForm = true;
    });
  }

  onVolumeNumberChange() {
    setState(() {
      hasTouchedForm = true;
    });
  }

  TextButton _buildUpdateButton() {
    if (updateInProgress) {
      return TextButton(
        onPressed: null,
        child: Text('更新中...'),
      );
    } else {
      if (isDirtyOrTouched) {
        return TextButton(
          onPressed: () {
            Future<void> future = widget.onUpdateBookProgress(
                tryParseInt(episodeEditController.text, defaultValue: 0),
                tryParseInt(volumeEditController.text, defaultValue: 0));
            setState(() {
              updateInProgress = true;
            });

            future.whenComplete(() {
              if (mounted) {
                setState(() {
                  updateInProgress = false;
                });
              }
            });
          },
          child: Text('更新'),
        );
      }

      return TextButton(
        onPressed: null,
        child: Text('更新'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(defaultPortraitHorizontalOffset -
            defaultDensePortraitHorizontalOffset ==
        8.0);

    return ExpansionTile(
      key: PageStorageKey<String>('progress-${widget.collection.subject.id}'),
      initiallyExpanded: widget.expandAllProgressTiles,
      title: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: math.max(
                0,
                defaultPortraitHorizontalOffset -
                    defaultDensePortraitHorizontalOffset)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                ClickableCachedRoundedCover(
                  width: 48,
                  imageUrl: widget.collection.subject?.cover?.large ??
                      bangumiTextOnlySubjectCover,
                  height: 48,
                  contentType: BangumiContent.Subject,
                  id: widget.collection.subject.id.toString(),
                ),
                ButtonTheme.fromButtonThemeData(
                  data: smallButtonTheme(context),
                  child: OutlinedButton(
                    onPressed: () {
                      showSnackBarOnSuccess(
                          context,
                          Application.router.navigateTo(
                              context,
                              Routes.subjectCollectionManagementRoute
                                  .replaceFirst(RoutesVariable.subjectIdParam,
                                      widget.collection.subject.id.toString()),
                              transition: TransitionType.nativeModal),
                          hasSuccessfullyUpdatedCollectionLabel);
                    },
                    child: Text("编辑"),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Text(preferredNameFromSubjectBase(
                              widget.collection.subject,
                              widget.preferredSubjectInfoLanguage))),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      WrappableText(
                        '${widget.collection.completedEpisodesCount ?? '??'}/${widget.collection.subject.totalEpisodesCount ?? '??'}话  ',
                        textStyle: Theme.of(context).textTheme.caption,
                      ),
                      WrappableText(
                        '${widget.collection.completedVolumesCount ?? '??'}/${widget.collection.subject.totalVolumesCount ?? '??'}卷',
                        textStyle: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPortraitHorizontalOffset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              BookProgressUpdateField(
                fieldType: FieldType.Episode,
                totalEpisodesOrVolumeCount:
                    widget.collection.subject.totalEpisodesCount,
                subjectId: widget.collection.subject.id,
                textEditingController: episodeEditController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
              ),
              BookProgressUpdateField(
                fieldType: FieldType.Volume,
                totalEpisodesOrVolumeCount:
                    widget.collection.subject.totalVolumesCount,
                subjectId: widget.collection.subject.id,
                textEditingController: volumeEditController,
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 4.0)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildUpdateButton(),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
