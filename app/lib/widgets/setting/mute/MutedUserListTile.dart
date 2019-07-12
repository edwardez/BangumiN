import 'package:flutter/material.dart';
import 'package:munin/models/bangumi/setting/mute/MutedUser.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MutedUserListTile extends StatelessWidget {
  final MutedUser mutedUser;

  final Function(MutedUser mutedUser) onUnmute;

  const MutedUserListTile(
      {Key key, @required this.mutedUser, @required this.onUnmute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: InkWell(
        child: ListTile(
          title: Text(mutedUser.nickname),
          subtitle: Text('@${mutedUser.username}'),
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
                          onUnmute(mutedUser);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
      key: ValueKey('mute-setting-user-${mutedUser.username}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).primaryColor,
        child: const ListTile(
          trailing: Icon(Icons.delete),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        onUnmute(mutedUser);
      },
    );
  }
}
