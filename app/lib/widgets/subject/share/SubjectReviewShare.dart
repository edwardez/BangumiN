import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:munin/models/bangumi/common/BangumiImage.dart';
import 'package:munin/models/bangumi/subject/BangumiSubject.dart';
import 'package:munin/models/bangumi/subject/review/SubjectReview.dart';
import 'package:munin/redux/shared/LoadingStatus.dart';
import 'package:munin/shared/utils/misc/constants.dart';
import 'package:munin/shared/workarounds/munin_permission_handler/lib/permission_handler.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/common/ScaffoldWithRegularAppBar.dart';
import 'package:munin/widgets/subject/share/SubjectReviewPoster.dart';
import 'package:palette_generator/palette_generator.dart';

class SubjectReviewShare extends StatefulWidget {
  final BangumiSubject subject;
  final SubjectReview review;

  /// Whether nickname and avatar of the reviewer should be hided
  /// User can use a switch toggle to control this value
  /// The switch toggle will only be shown if this value is set to true on initial
  final bool hideReviewerInfo;

  const SubjectReviewShare(
      {Key key,
      @required this.subject,
      @required this.review,
      this.hideReviewerInfo = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectReviewShareState();
  }
}

class _SubjectReviewShareState extends State<SubjectReviewShare> {
  bool hideReviewerInfo;
  SubjectReview review;
  PaletteGenerator paletteGenerator;
  LoadingStatus imageProcessingStatus = LoadingStatus.Initial;

  final GlobalKey<SubjectReviewPosterState> _shareWidgetKey =
      GlobalKey<SubjectReviewPosterState>();

  @override
  void initState() {
    super.initState();
    hideReviewerInfo = widget.hideReviewerInfo;

    if (hideReviewerInfo) {
      review = anonymizeReview(widget.review);
    } else {
      review = widget.review;
    }
  }

  /// Strip all user info from the review
  /// Note: Strictly speaking, this review still contains PII info(still identifiable
  /// by date, score and comment). Maybe we should warn user about this?
  SubjectReview anonymizeReview(SubjectReview review) {
    return review.rebuild((b) => b
      ..metaInfo.update((metaInfoBuilder) => metaInfoBuilder
        ..nickName = 'Bangumi用户'
        ..username = ''
        ..avatar.replace(
            BangumiImage.useSameImageUrlForAll(
                bangumiAnonymousUserMediumAvatar))));
  }

  /// Checks and requests permission on Android
  Future<PermissionStatus> checkAndRequestPermissionOnAndroid() async {
    if (!Platform.isAndroid) {
      return PermissionStatus.unknown;
    }

    var status = await PermissionHandler().checkPermissionStatus(
        PermissionGroup.storage);
    if (status != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    }

    return await PermissionHandler().checkPermissionStatus(
        PermissionGroup.storage);
  }

  /// Currently this calculation might block ui thread
  /// However it looks like there is no easy way to use compute here
  /// TODO: move this to an isolate, the challenge is that we need to re-download
  /// and re-calculate the same image every time even visiting the same image
  /// every time if isolate is used, which might be an issue
  /// (putting palette generator in main thread means color can be cached, and
  /// we can also reuse cached image provider if there is any).
  Future<void> _updatePaletteGenerator(String imageUrl) async {
    try {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        CachedNetworkImageProvider(imageUrl),
        maximumColorCount: 1,
      );
    } catch (exception, stack) {
      print(exception);
      print(stack);
      if (exception is TimeoutException) {
        imageProcessingStatus = LoadingStatus.TimeoutException;
      } else {
        imageProcessingStatus = LoadingStatus.UnknownException;
      }
    }

    setState(() {});
  }

  Widget _buildPosterBody(BuildContext context) {
    if (paletteGenerator == null) {
      if (imageProcessingStatus.isException) {
        String errorText = '生成海报失败';
        if (imageProcessingStatus == LoadingStatus.TimeoutException) {
          errorText += '，加载图片超时。';
        }

        return Center(
          child: Text(errorText),
        );
      }

      _updatePaletteGenerator(widget.subject.cover.small);
      return Center(
        child: Text('正在生成海报...'),
      );
    }

    PaletteColor primaryColor;
    if (paletteGenerator.paletteColors.isEmpty) {
      /// This PaletteColor instance will only be used for getting title color, so population is
      /// arbitrarily set to 1
      primaryColor = PaletteColor(Colors.grey, 1);
    } else {
      primaryColor = paletteGenerator.paletteColors[0];
    }

    List<Widget> widgets = [];
    widgets.add(SubjectReviewPoster(
      key: _shareWidgetKey,
      subject: widget.subject,
      review: review,
      themeColor: primaryColor.color,
    ));

    if (widget.hideReviewerInfo) {
      widgets.add(SwitchListTile.adaptive(
        title: Text('不分享评论者信息'),
        value: hideReviewerInfo,
        onChanged: (bool value) {
          setState(() {
            hideReviewerInfo = value;
            if (hideReviewerInfo) {
              review = anonymizeReview(widget.review);
            } else {
              review = widget.review;
            }
          });
        },
      ));
    }

    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          child: OutlineButton(
            child: Text(
              '保存到相册',
            ),
            onPressed: () async {
              var status = await checkAndRequestPermissionOnAndroid();
              if (status == PermissionStatus.denied) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('保存失败：没有写入图片的权限。'),
                ));
                return;
              }

              Uint8List uint8List =
              await _shareWidgetKey.currentState.capturePng();
              final result = await ImageGallerySaver.save(uint8List);
              if (result) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('保存成功'),
                ));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('保存失败，可能因为没有权限或其它错误。'),
                ));
              }
            },
          ),
        )
      ],
    ));

    return ListView(
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithRegularAppBar(
        appBar: AppBar(elevation: defaultAppBarElevation, title: Text('预览')),
        safeAreaChild: Builder(
          builder: (BuildContext builderContext) {
            return _buildPosterBody(builderContext);
          },
        ),
        safeAreaChildHorizontalPadding: 0);
  }
}
