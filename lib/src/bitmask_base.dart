/// A Bitmask class where each bit is specified by an enumeration value.
class EnumeratedBitmask<E extends Enum> {
  /// Construct a bitmask with no bits set.
  EnumeratedBitmask();

  /// Get the bitmask as an integer.
  int get flags =>
      _mask.fold(0, (int value, E flag) => value | 1 << flag.index);

  /// Set the bit specified by the enumeration value.
  operator |(E bit) {
    _mask.add(bit);
    return this;
  }

  final Set<E> _mask = <E>{};
}
