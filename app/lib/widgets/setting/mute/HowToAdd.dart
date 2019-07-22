import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:munin/widgets/shared/dialog/common.dart';

showHowToAddUserDialog(BuildContext context) {
  showMuninSingleActionDialog(context,
      title: '如何添加想屏蔽的用户',
      dialogBody: '在app内前往用户主页，点击"屏蔽用户"按钮进行添加。'
          '你也可以点击屏蔽页面下方'
          '的"导入以绝交用户"来导入已绝交的用户。\n'
          '由于Bangumi的限制，目前暂时无法以搜索用户名的方式进行添加。\n\n'
          '屏蔽作用于除通知以外的地方(Bangumi已经提供了可以屏蔽通知的"绝交"功能。)');
}

showHowToAddGroupDialog(BuildContext context) {
  showMuninSingleActionDialog(context,
      title: '如何添加想屏蔽的小组',
      dialogBody: '在app内长按帖子图标会弹出"屏蔽此小组"选项，选择后即可屏蔽。\n'
          '由于Bangumi的限制，目前暂时无法以搜索小组名的方式进行添加。');
}
