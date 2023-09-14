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

    test('fromInt', () {
      var bits = 13;
      var mask = Bitmask.fromInt(bits, 6);
      expect(mask.flags, bits);
    });

    test('fromInt invalid size', () {
      expect(() => Bitmask.fromInt(13, 0), throwsA(isArgumentError));
      expect(() => Bitmask.fromInt(13, -1), throwsA(isArgumentError));
      expect(() => Bitmask.fromInt(13, 64), throwsA(isArgumentError));
      expect(Bitmask.fromInt(13, 1).flags, 1);
      expect(Bitmask.fromInt(13, 63).flags, 13);
    });

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

    test('operator ~', () {
      var mask = Bitmask(MaskBits.values.length);
      mask[MaskBits.one.index] = true;
      mask[MaskBits.three.index] = true;
      var mask2 = ~mask;
      expect(mask2.flags, 5);
    });

    test('bitwise AND of two Bitmasks', () {
      var mask = Bitmask(MaskBits.values.length);
      mask[MaskBits.one.index] = true;
      mask[MaskBits.three.index] = true;
      var mask2 = Bitmask(MaskBits.values.length);
      mask2[MaskBits.one.index] = true;
      expect((mask & mask2).flags, 2);
    });

    test('bitwise AND of two Bitmasks that are not same size', () {
      var mask = Bitmask(4);
      var mask2 = Bitmask(6);
      expect(() => mask & mask2, throwsA(isArgumentError));
    });

    test('bitwise OR of two Bitmasks', () {
      var mask = Bitmask(MaskBits.values.length);
      mask[MaskBits.one.index] = true;
      mask[MaskBits.three.index] = true;
      var mask2 = Bitmask(MaskBits.values.length);
      mask2[MaskBits.two.index] = true;
      expect((mask | mask2).flags, 14);
    });

    test('bitwise OR of two Bitmasks that are not same size', () {
      var mask = Bitmask(4);
      var mask2 = Bitmask(6);
      expect(() => mask | mask2, throwsA(isArgumentError));
    });

    test('bitwise XOR of two Bitmasks', () {
      var mask = Bitmask(MaskBits.values.length);
      mask[MaskBits.one.index] = true;
      mask[MaskBits.three.index] = true;
      var mask2 = Bitmask(MaskBits.values.length);
      mask2[MaskBits.two.index] = true;
      mask2[MaskBits.one.index] = true;
      expect((mask ^ mask2).flags, 12);
    });

    test('bitwise XOR of two Bitmasks that are not same size', () {
      var mask = Bitmask(4);
      var mask2 = Bitmask(6);
      expect(() => mask ^ mask2, throwsA(isArgumentError));
    });

    test('operator ==', () {
      var mask = Bitmask(4);
      expect(mask == mask, true);

      var object = Object();
      expect(mask == object, false);

      var mask2 = Bitmask(4);
      expect(mask == mask2, true);

      mask[1] = true;
      expect(mask == mask2, false);

      var mask3 = Bitmask(6);
      expect(mask == mask3, false);

      mask2[2] = true;
      expect(mask == mask2, false);
    });

    test('operator !=', () {
      var mask = Bitmask(4);
      expect(mask != mask, false);

      var object = Object();
      expect(mask != object, true);

      var mask2 = Bitmask(4);
      expect(mask != mask2, false);

      mask[1] = true;
      expect(mask != mask2, true);

      var mask3 = Bitmask(6);
      expect(mask != mask3, true);

      mask2[2] = true;
      expect(mask != mask2, true);
    });

    test('fromList', () {
      var mask = Bitmask.fromList([1, 3, 5], 8);
      expect(mask.flags, 42);
    });

    test('invalid input in fromList', () {
      // test various mask sizes
      expect(() => Bitmask.fromList([], -1), throwsA(isArgumentError));
      expect(() => Bitmask.fromList([], 0), throwsA(isArgumentError));
      var _ = Bitmask.fromList([], 1);
      _ = Bitmask.fromList([], 63);
      expect(() => Bitmask.fromList([], 64), throwsA(isArgumentError));

      // test invalid bits in list
      expect(() => Bitmask.fromList([4, -1, 5], 6), throwsA(isArgumentError));
      expect(() => Bitmask.fromList([4, 1, 6], 6), throwsA(isArgumentError));
      _ = Bitmask.fromList([0, 5], 6);
    });
  });
}
