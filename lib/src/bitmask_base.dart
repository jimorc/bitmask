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
  /// Throws ArgumentError if the bit number is invalid (< 1 or greater
  /// than 63).
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
    if (size < 1 || size > 63) {
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
    if (size < 1 || size > 63) {
      throw ArgumentError('Bitmask.fromList: Bitmask size must be between'
          ' 1 and 63.');
    }
    var mask = Bitmask(size);
    for (var bit in bits) {
      if (bit < 0 || bit >= size) {
        throw ArgumentError('Bitmask.fromList: Attempting to set a bit '
            'that is less than 0 or greater than the size of the Bitmask.');
      }
      mask[bit] = true;
    }
    return mask;
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
  ///
  /// Throws ArgumentError if the bit number is invalid (< 0 or greater
  /// than the number of bits in the mask).
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
  ///
  /// Throws ArgumentError if the bit number is invalid (< 0 or greater
  /// than the number of bits in the mask).
  bool isSet(int bit) {
    if (bit < 0 || bit > _mask.length - 1) {
      throw ArgumentError('Bitmask.isSet: Request to check bit: \'$bit\''
          ' is invalid.');
    }
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
    if (bit < 0 || bit >= _mask.length) {
      throw ArgumentError('Bitmask.operator []=: Request to set bit: '
          '\'$bit\' is invalid.');
    }
    _mask[bit] = value;
  }

  /// Create a Bitmask of the bitwise complement of this object.
  Bitmask operator ~() {
    var newMask = this;
    for (var entry in newMask._mask.entries) {
      newMask._mask[entry.key] = !entry.value;
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
    Bitmask newMask = this;
    for (var entry in other._mask.entries) {
      newMask._mask[entry.key] =
          (newMask._mask[entry.key] ?? false) & entry.value;
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
    Bitmask newMask = this;
    for (var entry in other._mask.entries) {
      newMask._mask[entry.key] =
          (newMask._mask[entry.key] ?? false) | entry.value;
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
    Bitmask newMask = this;
    for (var entry in other._mask.entries) {
      newMask._mask[entry.key] =
          (newMask._mask[entry.key] ?? false) ^ entry.value;
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

  final Map<int, bool> _mask = <int, bool>{};
}
