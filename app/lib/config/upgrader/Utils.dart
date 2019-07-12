import 'package:upgrader/upgrader.dart';

appCastToString(AppcastItem appCastItem) {
  return 'AppcastItem{title: ${appCastItem.title}, \n'
      'dateString: ${appCastItem.dateString}, \n'
      'itemDescription: ${appCastItem.itemDescription}, \n'
      'releaseNotesURL: ${appCastItem.releaseNotesURL}, \n'
      'minimumSystemVersion: ${appCastItem.minimumSystemVersion}, \n'
      'maximumSystemVersion: ${appCastItem.maximumSystemVersion}, \n'
      'fileURL: ${appCastItem.fileURL}, \n'
      'contentLength: ${appCastItem.contentLength}, \n'
      'versionString: ${appCastItem.versionString}, \n'
      'osString: ${appCastItem.osString}, \n'
      'displayVersionString: ${appCastItem.displayVersionString}, \n'
      'infoURL: ${appCastItem.infoURL}, \n'
      'tags: ${appCastItem.tags}}';
}
