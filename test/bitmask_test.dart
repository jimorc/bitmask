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
      expect(mask.toInt(), 0);
    });

    test('set enumerated bit', () {
      var mask = EnumeratedBitmask<MaskBits>();
      mask |= MaskBits.two;
      expect(mask.toInt(), 4);
      mask |= MaskBits.zero;
      expect(mask.toInt(), 5);
    });
  });
}
