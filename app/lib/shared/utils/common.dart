// upgrade a link to https
// TODO: use built_value custom serializer to handle this at parsing time
upgradeToHttps(String link) {
  if (link?.runtimeType != String) {
    return link;
  }

  return link.replaceFirst('http://', 'https://');
}
