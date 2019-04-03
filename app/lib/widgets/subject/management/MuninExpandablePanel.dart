import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

/// edward: essentially the same as [ExpandablePanel], but the controller is exposed
class MuninExpandablePanel extends StatelessWidget {
  /// If specified, the header is always shown, and the expandable part is shown under the header
  final Widget header;

  /// The widget shown in the collspaed state
  final Widget collapsed;

  /// The widget shown in the expanded state
  final Widget expanded;

  /// If true then the panel is expanded initially
  final bool initialExpanded;

  /// If true, the header can be clicked by the user to expand
  final bool tapHeaderToExpand;

  /// If true, an expand icon is shown on the right
  final bool hasIcon;

  /// Builds an Expandable object
  final ExpandableBuilder builder;

  /// Expand/collapse icon placement
  final ExpandablePanelIconPlacement iconPlacement;

  final ExpandableController expandableController;

  static Widget defaultExpandableBuilder(
      BuildContext context, Widget collapsed, Widget expanded) {
    return Expandable(
      collapsed: collapsed,
      expanded: expanded,
    );
  }

  MuninExpandablePanel(
      {this.collapsed,
      this.header,
      this.expanded,
      this.initialExpanded = false,
      this.tapHeaderToExpand = true,
      this.hasIcon = true,
      this.iconPlacement = ExpandablePanelIconPlacement.right,
      this.builder = defaultExpandableBuilder,
      this.expandableController});

  @override
  Widget build(BuildContext context) {
    Widget buildHeaderRow(Widget child) {
      if (!hasIcon) {
        return child;
      } else {
        final rowChildren = <Widget>[
          Expanded(
            child: child,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ExpandableIcon(),
          ),
        ];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: iconPlacement == ExpandablePanelIconPlacement.right
              ? rowChildren
              : rowChildren.reversed.toList(),
        );
      }
    }

    Widget buildHeader(Widget child) {
      return tapHeaderToExpand
          ? ExpandableButton(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 45.0), child: child))
          : child;
    }

    Widget buildWithHeader() {
      return Column(
        children: <Widget>[
          buildHeaderRow(buildHeader(header)),
          builder(context, collapsed, expanded)
        ],
      );
    }

    Widget buildWithoutHeader() {
      return buildHeaderRow(builder(context, buildHeader(collapsed), expanded));
    }

    return ExpandableNotifier(
      controller: expandableController ?? ExpandableController(initialExpanded),
      child: this.header != null ? buildWithHeader() : buildWithoutHeader(),
    );
  }
}
