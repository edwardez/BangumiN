import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

launchBrowser(BuildContext context, String url, {popContext = false}) {
  if (popContext) {
    Navigator.pop(context);
  }
  launch(url);
}
