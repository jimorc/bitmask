const int _minimumBitmaskSize = 1;
const int _maximumBitmaskSize = 63;

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
  void unSet(int bit) {
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
