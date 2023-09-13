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

    test('set a bit', () {
      var mask = EnumeratedBitmask<MaskBits>();
      mask.set(MaskBits.two);
      expect(mask.flags, 4);
      mask.set(MaskBits.zero);
      expect(mask.flags, 5);
    });

    test('isSet', () {
      var mask = EnumeratedBitmask();
      mask.set(MaskBits.one);
      mask.set(MaskBits.three);
      expect(mask.isSet(MaskBits.zero), false);
      expect(mask.isSet(MaskBits.one), true);
      expect(mask.isSet(MaskBits.two), false);
      expect(mask.isSet(MaskBits.three), true);
    });

    test('operator []', () {
      var mask = EnumeratedBitmask();
      mask.set(MaskBits.one);
      mask.set(MaskBits.three);
      expect(mask[MaskBits.zero], false);
      expect(mask[MaskBits.one], true);
      expect(mask[MaskBits.two], false);
      expect(mask[MaskBits.three], true);
    });

    test('operator []= to set a bit', () {
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
