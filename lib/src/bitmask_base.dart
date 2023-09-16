const int _minimumBitmaskSize = 1;
const int _maximumBitmaskSize = 63;

/// A Bitmask class, which contains a collection of single bits.
///
/// There are four ways to construct a Bitmap object:
/// ```dash
/// // Create a Bitmask of 6 bits all set to 0
/// final mask1 = Bitmask(6);
/// // Create a Bitmask of 10 bits, with bits 1, 3, and 5 set to 1.
/// final mask2 = Bitmask.fromInt(21, 10);
/// // Create a Bitmask of 4 bits, with bits 1 and 3 set.
/// final mask3 = Bitmask.fromList([1, 3], 4);
/// // Create a Bitmask that is a deep copy of another.
/// final mask4 = Bitmask.fromBitmask(mask2);
/// ```
/// There are two ways to set individual bits, and two ways to unset
/// individual bits:
/// ```dash
/// // To set a bit, use either:
/// mask2.set(4); // Set bit 4 to 1 (true);
/// mask2[4] = true;  // Set the same bit to 1 (true)
/// // To unset a bit, use either:
/// mask2.unset(3);  // Set bit 3 to 0 (false)
/// mask2[3] = false; // Set same bit to 0 (false)
/// ```
/// The normal bit-wise operations are supported:
/// ```dash
/// // Bit-wise AND.
/// var mask5 = mask1 & mask2;
/// // Bit-wise OR.
/// var mask6 = mask1 | mask2;
/// // Bit-wise XOR.
/// var mask7 = mask1 ^ mask2;
/// // Bit-wise NOT.
/// var mask8 = ~mask1;
///```
///To convert to and from an integer:
///```dash
/// // Create an 8 bit Bitmask object with bits 1, 3, and 5 set.
/// var mask9 = Bitmask.fromInt(21, 8);
/// // Get integer value from Bitmask object
/// var bits = mask9.flags; // bits contains value 21.
/// ```
/// To reset all bits in a Bitmask object to 0 (false), call clear().
/// ```dash
/// mask9.clear();  // mask9 now contains all zeroes.
/// ```
/// Dart does not support generic enumerations, so Bitmask constructors
/// and methods use integer arguments. It is possible to use enumerations
/// with Bitmask by converting the emumeration values to integers as follows:
/// ```dash
/// enum Maskbits { zero, one, two, three, four }
///
/// var mask1 = Bitmask(Maskbits.values().length);
/// mask1[Maskbits.one.index] = true; // Set bit 1.
/// // Create Bitmask object to hold all Maskbits, with bits 1 and 2 set to 1
/// var mask2 = Bitmask.fromList([Maskbits.one.index, Maskbits.two.index],
///     Maskbits.values().length);
/// ```
/// Here is a program that exercises the Bitmask class. It is the same
/// as the example program:
/// ```dash
/// import 'package:bitmask/bitmask.dart';
///
/// enum Maskbits { zero, one, two, three, four }
///
/// void main() {
///   var mask1 = Bitmask(6);
///   // set bits 1 and 3.
///   mask1[1] = true;
///   mask1.set(3); // same as mask1[3] = true;
///   // set, then unset bit 5
///   mask1[5] = true;
///   mask1.unset(5); // same as mask1[5] = false;
///
///   // sets bits 0, 2, and 3.
///   var mask2 = Bitmask.fromInt(13, 6); // sets bits 0, 2, and 3.
///
///   // set bits 0, 3, and 4.
///   var mask3 = Bitmask.fromList(
///       [Maskbits.zero.index, Maskbits.three.index, Maskbits.four.index], 6);
///
///   print('mask1.flags = ${mask1.flags.toRadixString(2)}');
///   print('mask2.flags = ${mask2.flags.toRadixString(2)}');
///   print('mask3.flags = ${mask3.flags.toRadixString(2)}');
///
///   print('mask1 & mask2 = ${(mask1 & mask2).flags.toRadixString(2)}');
///   print('mask1 & mask3 = ${(mask1 & mask3).flags.toRadixString(2)}');
///   print('mask2 & mask3 = ${(mask2 & mask3).flags.toRadixString(2)}');
///
///   print('mask1 | mask2 = ${(mask1 | mask2).flags.toRadixString(2)}');
///   print('mask1 | mask3 = ${(mask1 | mask3).flags.toRadixString(2)}');
///   print('mask2 | mask3 = ${(mask2 | mask3).flags.toRadixString(2)}');
///
///   print('~mask1 = ${(~mask1).flags.toRadixString(2)}');
///   print('~mask2 = ${(~mask2).flags.toRadixString(2)}');
///   print('~mask3 = ${(~mask3).flags.toRadixString(2)}');
///
///   var mask4 = Bitmask.fromBitmask(mask3);
///   print('mask4 = ${mask4.flags.toRadixString(2)}');
///   print('mask4 == mask3: ${mask4 == mask3}');
///   print('identical(mask4, mask3): ${identical(mask4, mask3)}');
///
///   mask3.clear();
///   print('After mask3.clear(), mask3 = ${mask3.flags.toRadixString(2)}');
/// }
///
/// // prints the following:
/// // mask1.flags = 1010
/// // mask2.flags = 1101
/// // mask3.flags = 11001
/// // mask1 & mask2 = 1000
/// // mask1 & mask3 = 1000
/// // mask2 & mask3 = 1001
/// // mask1 | mask2 = 1111
/// // mask1 | mask3 = 11011
/// // mask2 | mask3 = 11101
/// // ~mask1 = 110101
/// // ~mask2 = 110010
/// // ~mask3 = 100110
/// // mask4 = 11001
/// // mask4 == mask3: true
/// // identical(mask4, mask3): false
/// // After mask3.clear(), mask3 = 0
/// ```
class Bitmask {
  /// Construct a bitmask with no bits set.
  ///
  /// _numberOfBits_ is the number of bits in the BitMask. The minimum
  /// value for this argument is 1; a Bitmask of zero or a negative
  /// size does not make sense. The maximum
  /// value for this argument is 63 as that is the size of a bitmask that
  /// can fit in an integer. This value should be no larger than 52 if
  /// the BitMask is used on the Web because that is the largest size that
  /// can be reliably set in Javascript.
  ///
  /// Throws ArgumentError if the bit number is invalid (< 1 or greater
  /// than 63).
  Bitmask(int numberOfBits) {
    if (numberOfBits < _minimumBitmaskSize) {
      throw ArgumentError('Bitmask constructor: Attempting to create a '
          "Bitmask size less than one bit.");
    }
    if (numberOfBits > _maximumBitmaskSize) {
      throw ArgumentError('Bitmask constructor: Attempting to create a '
          'Bitmask size larger than 63 bits in size.');
    }
    _mask = List<bool>.filled(numberOfBits, false, growable: false);
  }

  /// Create a Bitmask from an integer value.
  ///
  /// _bits_ is the integer value to create the Bitmask for.
  ///
  /// _size_ is the number of bits in the Bitmask. No check is made to
  /// ensure that the size of the Bitmask is large enough to hold all
  /// of the bits in _bits_. The minimum
  /// value for this argument is 1; a Bitmask of zero or a negative
  /// size does not make sense. The maximum
  /// value for this argument is 63 as that is the size of a bitmask that
  /// can fit in an integer. This value should be no larger than 52 if
  /// the BitMask is used on the Web because that is the largest size that
  /// can be reliably set in Javascript.
  ///
  /// throws ArgumentError is _size_ is not between 1 and 63.
  factory Bitmask.fromInt(int bits, int size) {
    if (size < _minimumBitmaskSize || size > _maximumBitmaskSize) {
      throw ArgumentError('Bitmask.fromInt: Bitmask size must be between'
          ' 1 and 63.');
    }
    Bitmask mask = Bitmask(size);
    for (int i = 0; i < size; i++) {
      mask[i] = bits & 1 == 1;
      bits >>= 1;
    }
    return mask;
  }

  /// Create Bitmask with bits specified in a list set.
  ///
  /// _bits_ is the list of bits to set.
  ///
  /// _size_ is the number of bits in this Bitmask.
  ///
  /// Throws ArgumentError if _size_ is not between 1 and 63.
  ///
  /// Throws ArgumentError if any entry in _bits_ is outside the range
  /// of 0 and _size_ - 1.
  factory Bitmask.fromList(List<int> bits, int size) {
    if (size < _minimumBitmaskSize || size > _maximumBitmaskSize) {
      throw ArgumentError('Bitmask.fromList: Bitmask size must be between'
          ' 1 and 63.');
    }
    var mask = Bitmask(size);
    for (var bit in bits) {
      if (bit < _minimumBitmaskSize - 1 || bit >= size) {
        throw ArgumentError('Bitmask.fromList: Attempting to set a bit '
            'that is less than 0 or greater than the size of the Bitmask.');
      }
      mask[bit] = true;
    }
    return mask;
  }

  /// Create a Bitmask object that is a copy of another Bitmask object.
  ///
  /// This constructor is required because with
  /// ```dart
  /// var mask2 = mask1;
  /// ```
  /// both _mask1_ and _mask2_ point to the same object, not different objects
  /// with the same content. Also, dart does
  /// not allow overriding _operator =_, so we can't override it to
  /// produce the result that we want.
  factory Bitmask.fromBitmask(Bitmask other) {
    return Bitmask.fromInt(other.flags, other.length);
  }

  /// Set all bits to false.
  void clear() {
    _mask = List<bool>.filled(_mask.length, false, growable: false);
  }

  /// Get the bitmask as an integer.
  int get flags {
    var result = 0;
    for (var bit = 0; bit < _mask.length; bit++) {
      if (_mask[bit]) {
        result += 1 << bit;
      }
    }
    return result;
  }

  /// Set the bit specified by _bit_ to 1 (true).
  ///
  /// Throws ArgumentError if the bit number is invalid (< 0 or greater
  /// than the number of bits in the mask).
  void set(int bit) {
    if (bit < _minimumBitmaskSize - 1 || bit > _mask.length - 1) {
      throw ArgumentError('BitMask.set: Request to set bit \'$bit\' which'
          'is invalid.');
    }
    _mask[bit] = true;
  }

  // Set the bit specified by _bit_ to 0 (false).
  ///
  /// Throws ArgumentError if the bit number is invalid (< 0 or greater
  /// than the number of bits in the mask).
  void unset(int bit) {
    if (bit < _minimumBitmaskSize - 1 || bit > _mask.length - 1) {
      throw ArgumentError('BitMask.set: Request to set bit \'$bit\' which'
          'is invalid.');
    }
    _mask[bit] = false;
  }

  /// Check if a bit is set.
  ///
  /// Returns true if the bit is set, and false if the bit is not set.
  ///
  /// Throws ArgumentError if the bit number is invalid (< 0 or greater
  /// than the number of bits in the mask).
  bool isSet(int bit) {
    if (bit < _minimumBitmaskSize - 1 || bit > _mask.length - 1) {
      throw ArgumentError('Bitmask.isSet: Request to check bit: \'$bit\''
          ' is invalid.');
    }
    return _mask[bit];
  }

  /// Get the setting of a bit.
  ///
  /// Returns true if the bit is set, and false if the bit is not set.
  /// than the number of bits in the mask).
  ///
  /// Throws ArgumentError if the bit number is invalid (< 0 or greater
  /// than the number of bits in the mask).
  bool operator [](int bit) => isSet(bit);

  /// Set a bit to 1 (true) or 0 (false).
  ///
  /// Throws ArgumentError if the bit number is invalid (< 0 or greater
  /// than the number of bits in the mask).
  operator []=(int bit, bool value) {
    if (bit < _minimumBitmaskSize - 1 || bit >= _mask.length) {
      throw ArgumentError('Bitmask.operator []=: Request to set bit: '
          '\'$bit\' is invalid.');
    }
    _mask[bit] = value;
  }

  /// Create a Bitmask of the bitwise complement of this object.
  Bitmask operator ~() {
    var newMask = Bitmask.fromBitmask(this);
    for (var bit = 0; bit < _mask.length; bit++) {
      newMask[bit] = !_mask[bit];
    }
    return newMask;
  }

  /// Create a Bitmask that is the bitwise AND of one Bitmask with another.
  ///
  /// Throws ArgumentError if the Bitmasks are not the same size.
  Bitmask operator &(Bitmask other) {
    if (length != other.length) {
      throw ArgumentError('Bitmask.operator &: Attempting to do a bitwise'
          ' AND of two Bitmasks that are not the same size.');
    }
    Bitmask newMask = Bitmask.fromBitmask(this);
    for (int bit = 0; bit < _mask.length; bit++) {
      newMask[bit] &= other[bit];
    }
    return newMask;
  }

  /// Create a Bitmask that is the bitwise OR of one Bitmask with another.
  ///
  /// Throws ArgumentError if the Bitmasks are not the same size.
  Bitmask operator |(Bitmask other) {
    if (length != other.length) {
      throw ArgumentError('Bitmask.operator |: Attempting to do a bitwise'
          ' AND of two Bitmasks that are not the same size.');
    }
    Bitmask newMask = Bitmask.fromBitmask(this);
    for (var bit = 0; bit < _mask.length; bit++) {
      newMask[bit] |= other[bit];
    }
    return newMask;
  }

  /// Create a Bitmask that is the bitwise XOR of one Bitmask with another.
  ///
  /// Throws ArgumentError if the Bitmasks are not the same size.
  Bitmask operator ^(Bitmask other) {
    if (length != other.length) {
      throw ArgumentError('Bitmask.operator |: Attempting to do a bitwise'
          ' AND of two Bitmasks that are not the same size.');
    }
    Bitmask newMask = Bitmask.fromBitmask(this);
    for (var bit = 0; bit < length; bit++) {
      newMask[bit] ^= other[bit];
    }
    return newMask;
  }

  /// Hash code of this object.
  @override
  int get hashCode => flags.hashCode;

  /// Equality operator.
  ///
  /// For two Bitmasks to be equal, they must be the same size and have
  /// all of the same bits set and unset.
  @override
  bool operator ==(Object other) {
    return other is Bitmask && length == other.length && flags == other.flags;
  }

  /// The number of bits in the mask.
  int get length => _mask.length;

  late List<bool> _mask;
}
