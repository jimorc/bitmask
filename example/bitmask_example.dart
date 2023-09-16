import 'package:bitmask/bitmask.dart';

enum Maskbits { zero, one, two, three, four }

void main() {
  var mask1 = Bitmask(6);
  // set bits 1 and 3.
  mask1[1] = true;
  mask1.set(3); // same as mask1[3] = true;
  // set, then unset bit 5
  mask1[5] = true;
  mask1.unset(5); // same as mask1[5] = false;

  // sets bits 0, 2, and 3.
  var mask2 = Bitmask.fromInt(13, 6); // sets bits 0, 2, and 3.

  // set bits 0, 3, and 4.
  var mask3 = Bitmask.fromList(
      [Maskbits.zero.index, Maskbits.three.index, Maskbits.four.index], 6);

  print('mask1.flags = ${mask1.flags.toRadixString(2)}');
  print('mask2.flags = ${mask2.flags.toRadixString(2)}');
  print('mask3.flags = ${mask3.flags.toRadixString(2)}');

  print('mask1 & mask2 = ${(mask1 & mask2).flags.toRadixString(2)}');
  print('mask1 & mask3 = ${(mask1 & mask3).flags.toRadixString(2)}');
  print('mask2 & mask3 = ${(mask2 & mask3).flags.toRadixString(2)}');

  print('mask1 | mask2 = ${(mask1 | mask2).flags.toRadixString(2)}');
  print('mask1 | mask3 = ${(mask1 | mask3).flags.toRadixString(2)}');
  print('mask2 | mask3 = ${(mask2 | mask3).flags.toRadixString(2)}');

  print('~mask1 = ${(~mask1).flags.toRadixString(2)}');
  print('~mask2 = ${(~mask2).flags.toRadixString(2)}');
  print('~mask3 = ${(~mask3).flags.toRadixString(2)}');

  var mask4 = Bitmask.fromBitmask(mask3);
  print('mask4 = ${mask4.flags.toRadixString(2)}');
  print('mask4 == mask3: ${mask4 == mask3}');
  print('identical(mask4, mask3): ${identical(mask4, mask3)}');

  mask3.clear();
  print('After mask3.clear(), mask3 = ${mask3.flags.toRadixString(2)}');
}

// prints the following:
// mask1.flags = 1010
// mask2.flags = 1101
// // mask3.flags = 11001
// mask1 & mask2 = 1000
// mask1 & mask3 = 1000
// mask2 & mask3 = 1001
// mask1 | mask2 = 1111
// mask1 | mask3 = 11011
// mask2 | mask3 = 11101
// ~mask1 = 110101
// ~mask2 = 110010
// ~mask3 = 100110
// mask4 = 11001
// mask4 == mask3: true
// identical(mask4, mask3): false
// After mask3.clear(), mask3 = 0