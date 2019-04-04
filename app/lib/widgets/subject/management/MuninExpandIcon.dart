// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A widget representing a rotating expand/collapse icon. The icon rotates
/// 180 deg when [isExpanded] changes, then reverts the animation if [isExpanded] reverts
/// The underlying icon is [Icons.expand_more].
///
/// The expand icon does not include a semantic label for accessibility. In
/// order to be accessible it should be combined with a label using
/// [MergeSemantics]. This is done automatically by the [ExpansionPanel] widget.
//
///
/// edward: It's essentially the same as the official [ExpandIcon], but just instead of a [IconButton],
/// an [Icon] is used so it's more compact, and it doesn't support [onPressed]
/// (expansion panel will handle it)
class MuninExpandIcon extends StatefulWidget {
  /// Creates an [MuninExpandIcon] with the given padding, and a callback that is
  /// triggered when the icon is pressed.
  const MuninExpandIcon(
      {Key key,
      this.isExpanded = false,
      this.size = 24.0,
      this.padding = const EdgeInsets.all(8.0)})
      : assert(isExpanded != null),
        assert(size != null),
        assert(padding != null),
        super(key: key);

  /// Whether the icon is in an expanded state.
  ///
  /// Rebuilding the widget with a different [isExpanded] value will trigger
  /// the animation, but will not trigger the [onPressed] callback.
  final bool isExpanded;

  /// The size of the icon.
  ///
  /// This property must not be null. It defaults to 24.0.
  final double size;

  /// The padding around the icon. The entire padded icon will react to input
  /// gestures.
  ///
  /// This property must not be null. It defaults to 8.0 padding on all sides.
  final EdgeInsetsGeometry padding;

  @override
  _MuninExpandIconState createState() => _MuninExpandIconState();
}

class _MuninExpandIconState extends State<MuninExpandIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween =
      Tween<double>(begin: 0.0, end: 0.5)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: kThemeAnimationDuration, vsync: this);
    _iconTurns = _controller.drive(_iconTurnTween);
    // If the widget is initially expanded, rotate the icon without animating it.
    if (widget.isExpanded) {
      _controller.value = math.pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(MuninExpandIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    return RotationTransition(
        turns: _iconTurns, child: const Icon(Icons.expand_more));
  }
}

/// An down/up arrow icon that toggles the state of [ExpandableController] when the user clicks on it.
/// The model is accessed via [ScopedModelDescendant].
class MuninExpandableIcon extends StatelessWidget {
  /// The padding around the icon. The entire padded icon will react to input
  /// gestures.
  ///
  /// This property must not be null. It defaults to 8.0 padding on all sides.
  final EdgeInsetsGeometry padding;

  const MuninExpandableIcon({Key key, this.padding = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ExpandableController.of(context);
    return MuninExpandIcon(
      isExpanded: controller.expanded,
    );
  }
}
