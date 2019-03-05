import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:munin/widgets/MoreOptions/more-options-home.dart';

class MuninHomePage extends StatefulWidget {
  MuninHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MuninHomePageState createState() => _MuninHomePageState();
}

class _MuninHomePageState extends State<MuninHomePage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: '搜索',
          onPressed: () {},
        ),
        IconButton(
          icon: new ClipRRect(
            borderRadius: new BorderRadius.circular(100.0),
            child: CachedNetworkImage(
              imageUrl: 'https://lain.bgm.tv/pic/user/m/icon.jpg',
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
          tooltip: '头像，更多选项',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MoreOptionsHomePage()),
            );
          },
        )
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter + BangumiN == Munin (a new Bangumi App)'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('动态')),
          BottomNavigationBarItem(icon: Icon(Icons.done), title: Text('进度')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('主页')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
