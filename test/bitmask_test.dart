import 'package:bitmask/bitmask.dart';
import 'package:test/test.dart';

enum MaskBits {
  zero,
  one,
  two,
  three,
}

void main() {
  group('A group of tests', () {
    test('empty constructor', () {
      var mask = EnumeratedBitmask<MaskBits>();
      expect(mask.flags, 0);
    });

    test('or enumerated bit', () {
      var mask = EnumeratedBitmask<MaskBits>();
      mask |= MaskBits.two;
      expect(mask.flags, 4);
      mask |= MaskBits.zero;
      expect(mask.flags, 5);
    });
  });
}
