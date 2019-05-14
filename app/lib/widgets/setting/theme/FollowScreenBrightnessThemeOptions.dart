import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:munin/models/bangumi/setting/MuninTheme.dart';
import 'package:munin/models/bangumi/setting/ThemeSetting.dart';
import 'package:munin/redux/setting/Common.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/setting/theme/Common.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:screen/screen.dart';

class FollowScreenBrightnessThemeOptions extends StatefulWidget {
  final bool showHiddenTheme;

  final ThemeSetting themeSetting;

  final Function(int newThreshold) onBrightnessSwitchThresholdChange;

  final Function(MuninTheme newTheme) onLightThemePreferenceChange;

  final Function(MuninTheme newTheme) onDarkThemePreferenceChange;

  const FollowScreenBrightnessThemeOptions(
      {Key key,
      @required this.showHiddenTheme,
      @required this.themeSetting,
      @required this.onBrightnessSwitchThresholdChange,
      @required this.onLightThemePreferenceChange,
      @required this.onDarkThemePreferenceChange})
      : super(key: key);

  @override
  _FollowScreenBrightnessThemeOptionsState createState() =>
      _FollowScreenBrightnessThemeOptionsState();
}

class _FollowScreenBrightnessThemeOptionsState
    extends State<FollowScreenBrightnessThemeOptions> {
  int currentScreenBrightness = 0;

  /// The actual slider value of brightness slider
  double brightnessThresholdSliderValue = 0.0;

  /// The rounded value of `brightnessThresholdSliderValue`, this value will be
  /// saved to store
  int get roundedBrightnessThreshold {
    return brightnessThresholdSliderValue.round();
  }

  Timer brightnessListenerTimer;

  listenToBrightnessChange() {
    /// Returns a value now since `Timer.periodic` waits for 1
    /// second to start
    Screen.brightness.then((newBrightness) {
      setState(() {
        currentScreenBrightness =
            roundDeviceBrightnessToPercentage(newBrightness);
      });
    });

    brightnessListenerTimer =
        Timer.periodic(Duration(seconds: 1), (timer) async {
      int nextScreenBrightness =
          roundDeviceBrightnessToPercentage(await Screen.brightness);
      if (nextScreenBrightness != currentScreenBrightness && mounted) {
        setState(() {
          currentScreenBrightness = nextScreenBrightness;
        });
      }
    });
  }

  int _formatBrightnessThreshold(double brightness) {
    return brightness.round();
  }

  @override
  void initState() {
    super.initState();
    brightnessThresholdSliderValue =
        widget.themeSetting.preferredFollowBrightnessSwitchThreshold.toDouble();
    listenToBrightnessChange();
  }

  @override
  void dispose() {
    brightnessListenerTimer?.cancel();
    super.dispose();
  }

  _sliverActiveTrackColor() {
    return Theme.of(context).sliderTheme.thumbColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(),
        ListTile(
          title: Text(
            '主题偏好',
            style: Theme.of(context)
                .textTheme
                .body2
                .copyWith(color: lightPrimaryDarkAccentColor(context)),
          ),
        ),
        ExpansionTile(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('明亮模式下偏好主题'),
              ),
              Text(widget.themeSetting.preferredFollowBrightnessLightTheme
                  .chineseName),
            ],
          ),
          children: <Widget>[
            for (MuninTheme theme
                in MuninTheme.availableLightThemes(widget.showHiddenTheme))
              ListTile(
                title: Text(theme.chineseName),
                trailing: buildThemeStyleTrailingIcon(
                    context,
                    widget.themeSetting.preferredFollowBrightnessLightTheme,
                    theme),
                onTap: () {
                  widget.onLightThemePreferenceChange(theme);
                },
              )
          ],
        ),
        ExpansionTile(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text('黑暗模式下偏好主题'),
              ),
              Text(widget
                  .themeSetting.preferredFollowBrightnessDarkTheme.chineseName),
            ],
          ),
          children: <Widget>[
            for (MuninTheme theme in MuninTheme.availableDarkThemes())
              ListTile(
                title: Text(theme.chineseName),
                trailing: buildThemeStyleTrailingIcon(
                    context,
                    widget.themeSetting.preferredFollowBrightnessDarkTheme,
                    theme),
                onTap: () {
                  widget.onDarkThemePreferenceChange(theme);
                },
              )
          ],
        ),
        Divider(),
        ListTile(
          title: Text(
            '主题切换阈值',
            style: Theme.of(context)
                .textTheme
                .body2
                .copyWith(color: lightPrimaryDarkAccentColor(context)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: <Widget>[
              Icon(
                OMIcons.wbSunny,
                size: 16.0,
              ),
              Expanded(
                /// Use a stack to place a device brightness indicator under real
                /// threshold slider. Device brightness indicator is also a slider
                /// which has all of its colors except `disabledThumbColor` set
                /// to [Colors.transparent]
                child: Stack(
                  children: <Widget>[
                    SliderTheme(
                      child: Slider(
                        value: currentScreenBrightness.toDouble(),
                        min: 0,
                        max: 100,
                        onChanged: null,
                      ),
                      data: Theme.of(context).sliderTheme.copyWith(
                            disabledThumbColor: _sliverActiveTrackColor(),
                            thumbShape: _CustomThumbShape(),
                            activeTrackColor: Colors.transparent,
                            activeTickMarkColor: Colors.transparent,
                            disabledActiveTickMarkColor: Colors.transparent,
                            disabledActiveTrackColor: Colors.transparent,
                            disabledInactiveTickMarkColor: Colors.transparent,
                            disabledInactiveTrackColor: Colors.transparent,
                            inactiveTickMarkColor: Colors.transparent,
                            inactiveTrackColor: Colors.transparent,
                            thumbColor: Colors.transparent,
                            overlayColor: Colors.transparent,
                            valueIndicatorColor: Colors.transparent,
                          ),
                    ),
                    Slider(
                      value: brightnessThresholdSliderValue,
                      min: 0,
                      max: 100,
                      label: '亮度在$roundedBrightnessThreshold%以下时使用黑暗模式',
                      onChanged: (double brightness) {
                        setState(() {
                          brightnessThresholdSliderValue = brightness;
                        });
                      },
                      onChangeEnd: (double newBrightnessThreshold) {
                        widget.onBrightnessSwitchThresholdChange(
                            _formatBrightnessThreshold(newBrightnessThreshold));
                      },
                    ),
                  ],
                ),
              ),
              Icon(
                OMIcons.wbSunny,
                size: 24.0,
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            MdiIcons.triangle,
            color: _sliverActiveTrackColor(),
          ),
          title: Text(
            '屏幕亮度，当前约为${currentScreenBrightness.round()}%',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        ListTile(
          leading: Icon(
            MdiIcons.circle,
            color: _sliverActiveTrackColor(),
          ),
          title: Text(
            '亮度阈值，屏幕亮度低于或等于这个值时就会切换到黑暗模式，当前约为$roundedBrightnessThreshold%',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}

Path trianglePath(double size, Offset thumbCenter, {bool invert = false}) {
  final Path thumbPath = Path();
  final double height = math.sqrt(3.0) / 2.0;
  final double halfSide = size / 2.0;
  final double centerHeight = size * height / 3.0;
  final double sign = invert ? -1.0 : 1.0;
  thumbPath.moveTo(
      thumbCenter.dx - halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.lineTo(thumbCenter.dx, thumbCenter.dy - 2.0 * sign * centerHeight);
  thumbPath.lineTo(
      thumbCenter.dx + halfSide, thumbCenter.dy + sign * centerHeight);
  thumbPath.close();
  return thumbPath;
}

/// Code is modified from official flutter example
class _CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 3.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset thumbCenter, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final double size = _thumbSize * sizeTween.evaluate(enableAnimation);
    final Path thumbPath = trianglePath(size, thumbCenter);
    canvas.drawPath(
        thumbPath, Paint()..color = colorTween.evaluate(enableAnimation));
  }
}
