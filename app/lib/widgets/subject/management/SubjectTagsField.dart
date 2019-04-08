import 'dart:collection';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:munin/shared/utils/collections/common.dart';
import 'package:munin/widgets/shared/chips/StrokeChoiceChip.dart';
import 'package:munin/widgets/subject/management/MuninExpandIcon.dart';
import 'package:munin/widgets/subject/management/MuninExpandablePanel.dart';
import 'package:quiver/strings.dart';

enum TagsType {
  /// List of tags that will show up after user click 'See more/选择标签'
  ExpandedCandidateTags,

  /// List of tags that will show up before user click 'See more/选择标签'
  HeaderSelectedTags
}

class SubjectTagsField extends StatefulWidget {
  final LinkedHashMap<String, bool> headerTags;

  final LinkedHashMap<String, bool> candidateTags;

  final int maxTags;

  /// [onChanged] is called every time LinkedHashSet of [selectedTags] has changed
  final ValueChanged<LinkedHashSet<String>> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _SubjectTagsFieldState();
  }

  SubjectTagsField(
      {@required LinkedHashMap<String, bool> headerTags,
      @required LinkedHashMap<String, bool> candidateTags,
      @required this.maxTags,
      this.onChanged})
      : this.candidateTags = candidateTags,
        this.headerTags = headerTags;
}

class _SubjectTagsFieldState extends State<SubjectTagsField> {
  LinkedHashSet<String> selectedTags = LinkedHashSet<String>();

  bool expanded = false;
  ExpandableController expandableController = ExpandableController(false);
  TextEditingController _newTagController = new TextEditingController();

  bool _hasReachedMaxTags() {
    return selectedTags.length >= widget.maxTags;
  }

  /// Build existing tags callback according to [tagsType], relevant bool in value
  /// of [tags] will be set accordingly
  /// If [tagsType] is [TagsType.ExpandedCandidateTags], relevant key/value pair
  /// in [widget.headerTags] won't be removed, instead it will be marked as [false]
  /// This is to ensure tags won't 'disappear' if user selects them, which might
  /// be confusing. These tags will be removed from [widget.headerTags] by  [_listenToExpandable]
  _onSelectedCallBackForExistingTag(LinkedHashMap<String, bool> tags,
      TagsType tagsType, String currentTagName) {
    if (_hasReachedMaxTags() && !tags[currentTagName]) {
      return null;
    }

    return (bool nextSelectionStatus) {
      setState(() {
        if (nextSelectionStatus) {
          selectedTags.add(currentTagName);
          widget.candidateTags[currentTagName] = true;
          widget.headerTags[currentTagName] = true;
        } else {
          selectedTags.remove(currentTagName);
          if (tagsType == TagsType.HeaderSelectedTags) {
            widget.headerTags[currentTagName] = false;
          } else {
            widget.headerTags.remove(currentTagName);
          }
          widget.candidateTags[currentTagName] = false;
        }
        if (widget.onChanged != null) {
          widget.onChanged(selectedTags);
        }
      });
    };
  }

  /// callback for 'Add new tag' chip, it will open a new dialog
  /// which let user enter a customized tag
  _onSelectedCallBackForTagInputDialog(BuildContext context) {
    if (_hasReachedMaxTags()) {
      return null;
    }

    return (bool selected) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("请输入你想要添加的新标签"),
            content: TextField(
              autofocus: true,
              controller: _newTagController,
              decoration: InputDecoration(
                labelText: '输入一个新标签',
                hintText: '半角逗号或空格会被过滤',
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("添加"),
                onPressed: () {
                  _newTagController.text =
                      _newTagController.text.replaceAll(RegExp(r',| '), '');
                  if (!isEmpty(_newTagController.text)) {
                    putOrMoveToLastInMap<String, bool>(
                        widget.headerTags, _newTagController.text, true);
                    putOrMoveToLastInMap<String, bool>(
                        widget.candidateTags, _newTagController.text, true);
                    putOrMoveToLastInSet<String>(
                        selectedTags, _newTagController.text);
                    if (widget.onChanged != null) {
                      widget.onChanged(selectedTags);
                    }
                  }

                  /// Navigator.of(context).pop() implicitly calls setState?
                  _newTagController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    };
  }

  void _showMaxTagsAlertDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("标签最多只能选择${widget.maxTags}个"),
          content: Text("取消选择一个已有标签即可再次选择"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Wrap a [GestureDetector] which will show a alert dialog to warn users that they've reached
  /// maximum number of tags, or the [choiceChip] itself without any wrapper
  /// if [wrapAlertDialog] is set to false
  Widget _maxTagsAlertWrapper(
      BuildContext context, Widget choiceChip, bool wrapAlertDialog) {
    if (wrapAlertDialog) {
      return GestureDetector(
        child: choiceChip,
        onTap: () {
          _showMaxTagsAlertDialog(context);
        },
      );
    }

    return choiceChip;
  }

  /// Build tags according to [tagsType]
  /// If [tagsType] is [TagsType.ExpandedCandidateTags], an extra 'new tag' chip will
  /// be added to the tail
  List<Widget> _buildTags(BuildContext context,
      LinkedHashMap<String, bool> tags, TagsType tagsType) {
    assert(tagsType == TagsType.ExpandedCandidateTags ||
        tagsType == TagsType.HeaderSelectedTags);

    List<Widget> chips = [];
    tags.forEach((String tagName, bool isSelected) {
      /// if user has selected maximum number of tags and this tag is currently
      /// not selected, it will be disabled and wrapped with an alert dialog
      /// if user tries to tap it, it's determined by [wrapAlertDialog]
      bool wrapAlertDialog = _hasReachedMaxTags() && !tags[tagName];

      StrokeChoiceChip choiceChip = StrokeChoiceChip(
        label: Text(tagName),
        selected: isSelected,
        onSelected: _onSelectedCallBackForExistingTag(tags, tagsType, tagName),
        labelStyle: Theme.of(context).chipTheme.labelStyle.copyWith(
            color:
            isSelected ? Theme
                .of(context)
                .primaryColor : null),
      );
      chips.add(_maxTagsAlertWrapper(context, choiceChip, wrapAlertDialog));
    });

    /// Add a 'Add new tag' chip if current tags are displayed in the expanded panel
    if (tagsType == TagsType.ExpandedCandidateTags) {
      bool wrapAlertDialog = _hasReachedMaxTags();
      StrokeChoiceChip choiceChip = StrokeChoiceChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.add), Text('新标签')],
        ),
        selected: false,
        onSelected: _onSelectedCallBackForTagInputDialog(context),
      );
      chips.add(_maxTagsAlertWrapper(context, choiceChip, wrapAlertDialog));
    }

    return chips;
  }

  @override
  void initState() {
    super.initState();
    expandableController.addListener(_listenToExpandable);
    widget.headerTags.forEach((String tagName, bool selected) {
      if (selected) {
        ///maybe notify [widget.onChanged] heere, too?
        selectedTags.add(tagName);
      }
    });
  }

  /// Listen to whether panels have been expanded or not, set [expanded]
  /// And remove unselected tags from [widget.headerTags] if user has deselected
  /// them
  _listenToExpandable() {
    if (expandableController.value) {
      setState(() {
        widget.headerTags
            .removeWhere((String tagName, bool selected) => !selected);
        expanded = true;
      });
    } else {
      setState(() {
        expanded = false;
      });
    }
  }

  @override
  void dispose() {
    expandableController.dispose();
    _newTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(MuninExpandablePanel(
      initialExpanded: expanded,
      expandableController: expandableController,
      hasIcon: false,

      /// Icon is right after text label(we add it manually)
      header: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "选择标签",
            ),
            MuninExpandableIcon(),
          ],
        ),
      ),
      expanded: Wrap(
        spacing: 4.0,
        children: _buildTags(
            context, widget.candidateTags, TagsType.ExpandedCandidateTags),
      ),
    ));

    if (!expanded) {
      children.add(Center(
        child: Wrap(
          spacing: 4.0,
          children: _buildTags(
              context, widget.headerTags, TagsType.HeaderSelectedTags),
        ),
      ));
    }

    return Column(
      children: children,
    );
  }
}
