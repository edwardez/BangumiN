import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:pub_semver/pub_semver.dart';

const _minimumAndroidDarkModeSdkInt = 29;
final _minimumRequiredIOSDarkModeVersion = Version(13, 0, 0);
final _iOSVersionRegex = RegExp(r'^(\d+)(?:\.(\d+))?(?:\.(\d+))?(.+)?$');

const _readableMinimumRequiredAndroidDarkModeVersion = 'Android 10或以上';
const _readableMinimumRequiredIOSDarkModeVersion = 'iOS 13.0或以上';

class DarkModeSupportInfo {
  final DarkModeAvailability darkModeAvailability;

  /// A human-readable string for current system version.
  ///
  /// Good:
  /// Android 10
  /// iOS 13.1
  /// Unknown
  ///
  /// Bad:
  /// AndroidSdk29
  /// AzulDarwinKernel
  final String currentSystemVersion;

  final List<String> minimumSupportedPlatformVersion;

  DarkModeSupportInfo(
    this.darkModeAvailability,
    this.currentSystemVersion,
    this.minimumSupportedPlatformVersion,
  );

  @override
  String toString() {
    return 'DarkModeSupportInfo{darkModeAvailability: $darkModeAvailability, '
        'currentSystemVersion: $currentSystemVersion, '
        'minimumSupportedPlatformVersion: $minimumSupportedPlatformVersion}';
  }
}

/// Checks current system support info for dark mode.
///
/// On iOS, [DarkModeSupportInfo.minimumSupportedPlatformVersion] only returns
/// iOS info(similar for Android), this is for passing store review guideline
/// and app fidelity purpose.
Future<DarkModeSupportInfo> checkDarkThemeSupport() async {
  final deviceInfo = DeviceInfoPlugin();
  var darkModeAvailability = DarkModeAvailability.unknown;
  var currentSystemVersion = 'Unknown';
  List<String> minimumSupportedPlatformVersion = [];

  if (Platform.isIOS) {
    final versionString = (await deviceInfo.iosInfo).systemVersion;
    try {
      final systemVersion = VersionExtension.parseIOSVersion(versionString);
      darkModeAvailability = systemVersion >= _minimumRequiredIOSDarkModeVersion
          ? DarkModeAvailability.available
          : DarkModeAvailability.unavailable;

      currentSystemVersion = 'iOS $versionString';
    } on FormatException {
      darkModeAvailability = DarkModeAvailability.unknown;
    }

    minimumSupportedPlatformVersion
        .add(_readableMinimumRequiredIOSDarkModeVersion);
  } else if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    var currentSdkInt = androidInfo?.version?.sdkInt;
    if (currentSdkInt != null) {
      currentSystemVersion = 'Android ${androidInfo.version.release}';

      darkModeAvailability = currentSdkInt <= _minimumAndroidDarkModeSdkInt
          ? DarkModeAvailability.available
          : DarkModeAvailability.unavailable;
    }

    minimumSupportedPlatformVersion
        .add(_readableMinimumRequiredAndroidDarkModeVersion);
  } else {
    minimumSupportedPlatformVersion.addAll([
      _readableMinimumRequiredAndroidDarkModeVersion,
      _readableMinimumRequiredIOSDarkModeVersion,
    ]);
  }
  return DarkModeSupportInfo(
    darkModeAvailability,
    currentSystemVersion,
    minimumSupportedPlatformVersion,
  );
}

enum DarkModeAvailability {
  available,
  unavailable,

  /// Cannot decide whether current platform supports dark mode.
  unknown
}

extension VersionExtension on Version {
  /// Creates a new [Version] by parsing [text].
  static Version parseIOSVersion(String text) {
    final match = _iOSVersionRegex.firstMatch(text);

    if (match == null) {
      throw FormatException('Could not parse "$text".');
    }
    if (match[4] != null) {
      print('Possible invalid version string. Expecting iOS string to be like '
          '13 or 13.1 or 13.1.1 but got $text');
    }

    try {
      var major = int.parse(match[1]);
      var minor = int.parse(match[2] ?? '0');
      var patch = int.parse(match[3] ?? '0');

      return Version(major, minor, patch);
    } on FormatException {
      throw FormatException('Could not parse "$text".');
    }
  }
}
