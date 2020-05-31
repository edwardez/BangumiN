import 'package:munin/shared/utils/misc/DeviceInfo.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  group('parseIOSVersion', () {
    test('Parses 13', () {
      expect(VersionExtension.parseIOSVersion('13'), Version(13, 0, 0));
    });

    test('Parses 13.0', () {
      expect(VersionExtension.parseIOSVersion('13.0'), Version(13, 0, 0));
    });

    test('Parses 13.1', () {
      expect(VersionExtension.parseIOSVersion('13.1'), Version(13, 1, 0));
    });

    test('Parses 13.1.2', () {
      expect(VersionExtension.parseIOSVersion('13.1.2'), Version(13, 1, 2));
    });

    test('Throws error on 13.1.2.1', () {
      expect(VersionExtension.parseIOSVersion('13.1.2'), Version(13, 1, 2));
    });

    test('Parses 13.1.2.1 and ignores version string after last minor', () {
      expect(VersionExtension.parseIOSVersion('13.1.2.1'), Version(13, 1, 2));
    });

    test('Throws error on invalidVersion', () {
      expect(() => VersionExtension.parseIOSVersion('invalidVersion'),
          throwsA(TypeMatcher<FormatException>()));
    });
  });
}
