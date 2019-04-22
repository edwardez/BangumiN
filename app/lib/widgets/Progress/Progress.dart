import 'package:flutter/material.dart';

class MuninSubjectProgress extends StatefulWidget {
  MuninSubjectProgress({Key key}) : super(key: key);

  @override
  _MuninSubjectProgressState createState() => _MuninSubjectProgressState();
}

class _MuninSubjectProgressState extends State<MuninSubjectProgress> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        title: Text('Lorem Ipsum'),
        subtitle: Text('$index'),
      );
    });
  }
}
