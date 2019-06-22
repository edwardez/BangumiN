import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/chips/StrokeChoiceChip.dart';

typedef ToChipStringName<T> = String Function(T chip);

typedef ChipLabelBuilder<T> = Widget Function(T chip);

typedef OnChipSelected<T> = void Function(T chip);

/// Layout of [FilterChipsGroup]
enum ChipsLayout {
  /// Wraps chip to next line
  Wrap,

  /// Chips are listed on a horizontally scrollable row.
  HorizontalList,
}

/// A list of filter chips group
class FilterChipsGroup<T> extends StatefulWidget {
  /// Padding between chips, padding won't be inserted before the first chip
  final double paddingBetweenChips;

  /// List of filter chips
  final List<T> filterChips;

  /// Builds the label of the chip.
  ///
  /// If not set, [toString] of the chip type will be displayed in a [Text] Widget.
  final ChipLabelBuilder<T> chipLabelBuilder;

  final OnChipSelected<T> onChipSelected;

  /// The current [selectedChip]
  /// If [selectedChip] is null, all chips will be rendered in unselected state
  /// If [selectedChip] is not null, it must be in [filterChips]
  final T selectedChip;

  /// Initial padding offset on the left side of the chip groups in pixel.
  ///
  /// It's a trailing white space on the left side.
  final double initialLeftOffset;

  final ChipsLayout chipsLayout;

  const FilterChipsGroup({
    Key key,
    @required this.filterChips,
    @required this.selectedChip,
    this.onChipSelected,
    this.chipLabelBuilder,
    this.chipsLayout = ChipsLayout.HorizontalList,
    this.paddingBetweenChips = 4.0,
    this.initialLeftOffset = 0.0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FilterChipsGroupState<T>();
  }
}

class _FilterChipsGroupState<T> extends State<FilterChipsGroup<T>> {
  T currentSelectedChipType;

  @override
  void initState() {
    super.initState();
    assert(widget.selectedChip == null ||
        widget.filterChips.contains(widget.selectedChip));

    currentSelectedChipType = widget.selectedChip;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chipWidgets = [];

    chipWidgets.add(Padding(
      padding: EdgeInsets.only(
        left: widget.initialLeftOffset,
      ),
    ));

    for (T filterChip in widget.filterChips) {
      bool isSelected = currentSelectedChipType == filterChip;
      Widget chipLabel;

      if (widget.chipLabelBuilder != null) {
        chipLabel = widget.chipLabelBuilder(filterChip);
      } else {
        chipLabel = Text(filterChip.toString());
      }

      chipWidgets.add(Padding(
        padding: EdgeInsets.only(right: widget.paddingBetweenChips),
        child: StrokeChoiceChip(
          label: chipLabel,
          selected: isSelected,
          onSelected: (isSelected) {
            if (isSelected) {
              setState(() {
                currentSelectedChipType = filterChip;
              });

              if (widget.onChipSelected != null) {
                widget.onChipSelected(filterChip);
              }
            }
          },
          labelStyle: Theme.of(context).chipTheme.labelStyle.copyWith(
              color: isSelected ? lightPrimaryDarkAccentColor(context) : null),
        ),
      ));
    }

    if (widget.chipsLayout == ChipsLayout.HorizontalList) {
      /// TODO: figure out a better way to constraint list size
      return Container(
        height: Theme.of(context).textTheme.body1.fontSize * 3.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            return chipWidgets[index];
          },
          itemCount: chipWidgets.length,
        ),
      );
    } else {
      assert(widget.chipsLayout == ChipsLayout.Wrap);

      /// TODO: figure out a better way to constraint list size
      return Wrap(
        children: chipWidgets,
      );
    }
  }
}
