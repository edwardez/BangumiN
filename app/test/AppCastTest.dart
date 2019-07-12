import 'dart:io';

import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  group('AppCast', () {
    String appCastXml;

    setUp(() async {
      appCastXml =
          File('lib/config/upgrader/production_appcast.xml').readAsStringSync();
    });

    test('verifies production upgarder xml is valid', () {
      final items = Appcast().parseItemsFromXMLString(appCastXml);

      Version newerVersion;
      for (var item in items) {
        expect(item.fileURL, isNotNull);
        expect(item.isCriticalUpdate, isNotNull);
        expect(item.itemDescription, isNotNull);

        final currentVersion = Version.parse(item.versionString);

        expect(currentVersion.isPreRelease, isFalse);
        if (newerVersion != null) {
          // In production, newer version must be higher than older one.
          expect(newerVersion.compareTo(currentVersion), isPositive);
        }

        newerVersion = currentVersion;
      }
    });
  });
}
