import 'package:flutter/material.dart';
import 'package:munin/widgets/setting/theme/Common.dart';

typedef SelectionLabelBuilder<T> = Widget Function(T selection);

/// A customized multi-selection widget that shows current selection by default,
/// and user can expand the panel to see and switch to other options.
class MuninExpansionSelection<T> extends StatelessWidget {
  /// Key that flutter users to keep expansion state.
  final PageStorageKey expansionKey;

  /// Title of the selection.
  final Widget title;

  final T currentSelection;

  /// Title builder of the option.
  final SelectionLabelBuilder<T> optionTitleBuilder;

  /// Subtitle builder of the option.
  ///
  /// Optional. Subtitle will not be shown if set to true.
  final SelectionLabelBuilder<T> optionSubTitleBuilder;

  /// All available options.
  final Iterable<T> options;

  final Function(T selectedOption) onTapOption;

  /// Whether divider among options should be set to transparent.
  ///
  /// Default to true. It set to false, divider color under current [Theme]
  /// will be used.
  final bool transparentDivider;

  const MuninExpansionSelection({
    Key key,
    @required this.expansionKey,
    @required this.title,
    @required this.currentSelection,
    @required this.optionTitleBuilder,
    @required this.onTapOption,
    @required this.options,
    this.optionSubTitleBuilder,
    this.transparentDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: transparentDivider
          ? Theme.of(context).copyWith(dividerColor: Colors.transparent)
          : Theme.of(context),
      child: ExpansionTile(
        key: expansionKey,
        title: Row(
          children: <Widget>[
            Expanded(
              child: title,
            ),
            optionTitleBuilder(currentSelection),
          ],
        ),
        children: <Widget>[
          for (var option in options)
            ListTile(
              title: optionTitleBuilder(option),
              subtitle: optionSubTitleBuilder == null
                  ? null
                  : optionSubTitleBuilder(option),
              trailing: buildTrailingIcon(context, currentSelection, option),
              onTap: () {
                onTapOption(option);
              },
            ),
        ],
      ),
    );
  }
}
