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

    test('isSet', () {
      var mask = EnumeratedBitmask();
      mask |= MaskBits.one;
      mask |= MaskBits.three;
      expect(mask.isSet(MaskBits.zero), false);
      expect(mask.isSet(MaskBits.one), true);
      expect(mask.isSet(MaskBits.two), false);
      expect(mask.isSet(MaskBits.three), true);
    });

    test('operator [] to set a bit', () {
      var mask = EnumeratedBitmask();
      mask[MaskBits.one] = true;
      mask[MaskBits.three] = true;
      expect(mask.isSet(MaskBits.zero), false);
      expect(mask.isSet(MaskBits.one), true);
      expect(mask.isSet(MaskBits.two), false);
      expect(mask.isSet(MaskBits.three), true);

      mask[MaskBits.two] = false;
      mask[MaskBits.three] = false;
      expect(mask.isSet(MaskBits.zero), false);
      expect(mask.isSet(MaskBits.one), true);
      expect(mask.isSet(MaskBits.two), false);
      expect(mask.isSet(MaskBits.three), false);
    });
  });
}
