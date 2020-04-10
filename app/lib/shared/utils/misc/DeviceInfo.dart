import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:pub_semver/pub_semver.dart';

const _minimumAndroidDarkModeSdkInt = 29;
final _minimumRequiredIOSDarkModeVersion = Version(13, 0, 0);

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
      final systemVersion = Version.parse(versionString);
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
