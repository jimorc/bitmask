/// A Bitmask class where each bit is specified by an enumeration value.
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
  /// Throws ArgumentError if _numberOfBits_ is less than 1.
  ///
  /// Throws ArgumentError if _numberOfBits_ is larger than 63.
  Bitmask(int numberOfBits) {
    if (numberOfBits < 1) {
      throw ArgumentError('Bitmask constructor: Attempting to create a '
          "Bitmask size less than one bit.");
    }
    if (numberOfBits > 63) {
      throw ArgumentError('Bitmask constructor: Attempting to create a '
          'Bitmask size larger than 63 bits in size.');
    }
    for (var i = 0; i < numberOfBits; i++) {
      _mask[i] = false;
    }
  }

  /// Get the bitmask as an integer.
  int get flags {
    var result = 0;
    for (var entry in _mask.entries) {
      if (entry.value) {
        result += (entry.value) ? 1 << entry.key : 0;
      }
    }
    return result;
  }

  /// Set the bit specified by the enumeration value to 1 (true).
  void set(int bit) {
    if (bit < 0 || bit > _mask.length - 1) {
      throw ArgumentError('BitMask.set: Request to set bit \'$bit\' which'
          'is invalid.');
    }
    _mask[bit] = true;
  }

  /// Check if a bit is set.
  ///
  /// Returns true if the bit is set, and false if the bit is not set.
  bool isSet(int bit) {
    for (var entry in _mask.entries) {
      if (bit == entry.key) {
        return entry.value;
      }
    }
    return false;
  }

  /// Get the setting of a bit.
  ///
  /// Returns true if the bit is set, and false if the bit is not set.
  bool operator [](int bit) => isSet(bit);

  /// Set a bit to 1 (true) or 0 (false).
  operator []=(int bit, bool value) {
    _mask[bit] = value;
  }

  final Map<int, bool> _mask = <int, bool>{};
}
