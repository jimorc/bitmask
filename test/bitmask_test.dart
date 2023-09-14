import 'package:bitmask/bitmask.dart';
import 'package:test/test.dart';

enum MaskBits {
  zero,
  one,
  two,
  three,
}

void main() {
  group('Bitmask tests', () {
    test('empty constructor', () {
      var mask = Bitmask(MaskBits.values.length);
      expect(mask.flags, 0);
    });

    (test('invalid Bitmask sizes', () {
      expect(() => Bitmask(-1), throwsA(isArgumentError));
      expect(() => Bitmask(0), throwsA(isArgumentError));
      expect(Bitmask(1).flags, 0);
      expect(Bitmask(63).flags, 0);
      expect(() => Bitmask(64).flags, throwsA(isArgumentError));
    }));

    test('set a bit', () {
      var mask = Bitmask(MaskBits.values.length);
      mask.set(MaskBits.two.index);
      expect(mask.flags, 4);
      mask.set(MaskBits.zero.index);
      expect(mask.flags, 5);
    });

    test('set invalid bit', () {
      var mask = Bitmask(MaskBits.values.length);
      expect(() => mask.set(-1), throwsA(isArgumentError));
      mask.set(0);
      expect(mask.flags, 1);
      expect(() => mask.set(4), throwsA(isArgumentError));
    });

    test('isSet', () {
      var mask = Bitmask(MaskBits.values.length);
      mask.set(MaskBits.one.index);
      mask.set(MaskBits.three.index);
      expect(mask.isSet(MaskBits.zero.index), false);
      expect(mask.isSet(MaskBits.one.index), true);
      expect(mask.isSet(MaskBits.two.index), false);
      expect(mask.isSet(MaskBits.three.index), true);
    });

    test('invalid bit in isSet', () {
      var mask = Bitmask(MaskBits.values.length);
      expect(() => mask.isSet(-1), throwsA(isArgumentError));
      var _ = mask.isSet(0);
      expect(() => mask.isSet(4), throwsA(isArgumentError));
    });

    test('operator []', () {
      var mask = Bitmask(MaskBits.values.length);
      mask.set(MaskBits.one.index);
      mask.set(MaskBits.three.index);
      expect(mask[MaskBits.zero.index], false);
      expect(mask[MaskBits.one.index], true);
      expect(mask[MaskBits.two.index], false);
      expect(mask[MaskBits.three.index], true);
    });

    test('invalid bit in []', () {
      var mask = Bitmask(MaskBits.values.length);
      expect(() => mask[-1], throwsA(isArgumentError));
      mask.set(0);
      expect(mask.flags, 1);
      expect(() => mask[4], throwsA(isArgumentError));
    });

    test('operator []= to set a bit', () {
      var mask = Bitmask(MaskBits.values.length);
      mask[MaskBits.one.index] = true;
      mask[MaskBits.three.index] = true;
      expect(mask.isSet(MaskBits.zero.index), false);
      expect(mask.isSet(MaskBits.one.index), true);
      expect(mask.isSet(MaskBits.two.index), false);
      expect(mask.isSet(MaskBits.three.index), true);

      mask[MaskBits.two.index] = false;
      mask[MaskBits.three.index] = false;
      expect(mask.isSet(MaskBits.zero.index), false);
      expect(mask.isSet(MaskBits.one.index), true);
      expect(mask.isSet(MaskBits.two.index), false);
      expect(mask.isSet(MaskBits.three.index), false);
    });

    test('invalid bit in operator []=', () {
      var mask = Bitmask(MaskBits.values.length);
      expect(() => mask[-1] = true, throwsA(isArgumentError));
      var _ = mask.isSet(0);
      expect(() => mask[4] = true, throwsA(isArgumentError));
    });
  });
}
