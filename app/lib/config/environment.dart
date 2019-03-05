import 'package:flutter/material.dart';
import 'package:munin/main.dart';

abstract class Env {
  static Env value;

  String bangumiOauthClientIdentifier;
  String bangumiOauthClientSecret;

  Env() {
    value = this;
    runApp(MuninApp(this));
  }

  String get name => runtimeType.toString();
}
