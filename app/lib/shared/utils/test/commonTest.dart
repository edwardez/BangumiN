import 'package:munin/shared/utils/common.dart';
import 'package:test/test.dart';

void main() {
  group('firstNChars', () {
    test('Adds trailing string.', () {
      expect(firstNChars('12345', 6, trailingOverflowText: '...'), '123...');
    });

    test(
        'Skips input if firstN is too small and trailingOverflowText is too large',
        () {
      expect(firstNChars('12345', 2, trailingOverflowText: '...'), '..');
    });
  });
}
