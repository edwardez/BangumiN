import 'package:munin/shared/utils/common.dart';
import 'package:test/test.dart';

void main() {
  group('firstNChars', () {
    test('Adds trailing string.', () {
      expect(firstNChars('12345', 4, trailingOverflowText: '...'), '1...');
    });

    test(
        'Skips input if firstN is too small and trailingOverflowText is too large',
        () {
      expect(firstNChars('12345', 2, trailingOverflowText: '...'), '..');
    });

    test('Skips stripping input if firstN is longer than input', () {
      expect(firstNChars('12345', 100, trailingOverflowText: '...'), '12345');
    });
  });
}
