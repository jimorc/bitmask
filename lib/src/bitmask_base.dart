/// A Bitmask class where each bit is specified by an enumeration value.
class EnumeratedBitmask<E extends Enum> {
  /// Construct a bitmask with no bits set.
  EnumeratedBitmask();

  /// Get the bitmask as an integer.
  int get flags =>
      _mask.fold(0, (int value, E flag) => value | 1 << flag.index);

  /// Set the bit specified by the enumeration value to 1 (true).
  void set(E bit) {
    _mask.add(bit);
  }

  /// Check if a bit is set.
  ///
  /// Returns true if the bit is set, and false if the bit is not set.
  bool isSet(E bit) {
    return _mask.contains(bit);
  }

  /// Get the setting of a bit.
  ///
  /// Returns true if the bit is set, and false if the bit is not set.
  bool operator [](E bit) => isSet(bit);

  /// Set a bit to 1 (true) or 0 (false).
  operator []=(E bit, bool value) {
    if (value) {
      _mask.add(bit);
    } else {
      _mask.remove(bit);
    }
  }

  final Set<E> _mask = <E>{};
}
