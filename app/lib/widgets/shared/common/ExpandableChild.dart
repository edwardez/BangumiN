import 'package:flutter/material.dart';

/// A child that has expand button. This is currently a one-way only operation.
/// Once expanded there is no way to go back.
/// Modified from [ExpansionTile].
class ExpandableChild extends StatefulWidget {
  final Widget child;

  /// Initial visible portion in percentage of the [child].
  final double initialVisiblePortion;

  /// Whether it should be initially expanded. If set to true, expand button
  /// will be hidden.
  final bool isExpanded;

  final String expandButtonText;

  const ExpandableChild(
      {Key key,
      @required this.child,
      @required this.initialVisiblePortion,
      this.isExpanded = false,
      this.expandButtonText = '展开全部'})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExpandableChildState();
  }
}

class _ExpandableChildState extends State<ExpandableChild>
    with TickerProviderStateMixin<ExpandableChild> {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);

  AnimationController _controller;
  Animation<double> _heightFactor;

  bool _isExpanded = false;

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  @override
  void initState() {
    super.initState();
    super.initState();

    _controller = AnimationController(
        value: widget.initialVisiblePortion ?? 0.0,
        duration: Duration(milliseconds: 200),
        vsync: this);
    _heightFactor = _controller.drive(_easeInTween);

    _isExpanded = PageStorage.of(context)?.readState(context) ??
        widget.isExpanded ??
        false;
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRect(
          child: Align(
            alignment: Alignment.topLeft,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),

        /// Shows expansion button only if widget is not initially expanded.
        if (!widget.isExpanded)
          _isExpanded
              ? Container()
              : Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                          child: Text(widget.expandButtonText),
                          onPressed: _handleTap),
                    )
                  ],
                ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Column(
              children: <Widget>[widget.child],
            ),
    );
  }
}
