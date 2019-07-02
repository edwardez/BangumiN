import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:munin/redux/app/AppState.dart';
import 'package:redux/redux.dart';

Store<AppState> findStore(BuildContext context) =>
    StoreProvider.of<AppState>(context);

AppState findAppState(BuildContext context) => findStore(context).state;
