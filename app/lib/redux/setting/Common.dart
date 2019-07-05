/// [Screen.brightness] returns a value in range [0,1], it needs to be converted
/// to a int percentage in range [0, 100]
int roundDeviceBrightnessToPercentage(double deviceBrightness) {
  assert(deviceBrightness >= 0.0 && deviceBrightness <= 1.0);

  return (deviceBrightness * 100).round();
}
