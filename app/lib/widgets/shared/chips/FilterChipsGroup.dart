import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:munin/styles/theme/Common.dart';
import 'package:munin/widgets/shared/chips/StrokeChoiceChip.dart';

typedef ToChipStringName<U> = String Function(U chip);

typedef OnChipSelected<U> = void Function(U chip);

/// A list of filter chips group
class FilterChipsGroup<T> extends StatefulWidget {
  /// Padding between chips, padding won't be inserted before the first chip
  final double paddingBetweenChips;

  /// List of filter chips
  final List<T> filterChips;

  /// A callback function that can find the name of the chip
  /// If unset, [T.toString()] will be used
  final ToChipStringName<T> chipNameRetriever;

  final OnChipSelected<T> onChipSelected;

  /// The current [selectedChip]
  /// If [selectedChip] is null, all chips will be rendered in unselected state
  /// If [selectedChip] is not null, it must be in [filterChips]
  final T selectedChip;

  /// Initial padding offset on the left side of the chip groups in pixel.
  ///
  /// It's a trailing white space on the left side.
  final double initialLeftOffset;

  const FilterChipsGroup({
    Key key,
    @required this.filterChips,
    @required this.selectedChip,
    this.onChipSelected,
    this.chipNameRetriever,
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
      bool isFirstChip = chipWidgets.isEmpty;
      String chipName;
      if (widget.chipNameRetriever != null) {
        chipName = widget.chipNameRetriever(filterChip);
      } else {
        chipName = filterChip.toString();
      }

      chipWidgets.add(Padding(
        padding: isFirstChip
            ? EdgeInsets.zero
            : EdgeInsets.only(left: widget.paddingBetweenChips),
        child: StrokeChoiceChip(
          label: Text(
            chipName,
          ),
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
  }
}
