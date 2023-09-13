/// A Bitmask class where each bit is specified by an enumeration value.
class EnumeratedBitmask<E extends Enum> {
  /// Construct a bitmask with no bits set.
  EnumeratedBitmask();

  /// Get the bitmask as an integer.
  int toInt() => _mask;

  /// Set the bit specified by the enumeration value.
  operator |(E bit) {
    _mask |= 1 << bit.index;
    return this;
  }

  int _mask = 0;
}
