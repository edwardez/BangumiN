import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showHowToAddUserDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('如何添加想屏蔽的用户'),
          content: Text('可以前往app内用户主页，点击"屏蔽用户"按钮进行添加。你也可以点击屏蔽页面下方'
              '的"导入以绝交用户"来导入已绝交的用户。\n\n'
              '由于Bangumi的限制，目前暂时无法以搜索用户名的方式进行添加。'),
          actions: <Widget>[
            FlatButton(
              child: Text('好的'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

showHowToAddGroupDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('如何添加想屏蔽的小组'),
          content: Text('在app内长按小组图标会弹出"屏蔽此小组"选项，选择后即可屏蔽。\n\n'
              '由于Bangumi的限制，目前暂时无法以搜索小组名的方式进行添加。'),
          actions: <Widget>[
            FlatButton(
              child: Text('好的'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
