import 'package:flutter/material.dart';
import 'package:munin/config/application.dart';
import 'package:munin/models/bangumi/setting/mute/MutedGroup.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MutedGroupListTile extends StatelessWidget {
  final MutedGroup mutedGroup;

  final Function(MutedGroup mutedGroup) onUnmute;

  const MutedGroupListTile(
      {Key key, @required this.mutedGroup, @required this.onUnmute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: InkWell(
        child: ListTile(
          title: Text(mutedGroup.groupNickname),
          subtitle: Text(
              'https://$bangumiMainHost/group/${mutedGroup.groupId}'),
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return SafeArea(
                  bottom: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        child: ListTile(
                          leading: Icon(OMIcons.clear),
                          title: Text('解除屏蔽'),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          onUnmute(mutedGroup);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
      key: ValueKey('mute-setting-group-${mutedGroup.groupId}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).primaryColor,
        child: const ListTile(
          trailing: Icon(Icons.delete),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        onUnmute(mutedGroup);
      },
    );
  }
}
