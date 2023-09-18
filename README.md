# bitmask

bitmask is a Dart package that provides a Bitmask class.

## Introduction

A Bitmask object contains
a collection of individual bits that may be set or not set (1 or 0).
Constructors and methods are provided for setting and unsetting individual
bits in a Bitmask and for applying operations such as bitwise ANDing, ORing, and XORing masks together, taking a bitwise complement, and for
getting the
integer value represented by the Bitmask object.

Bitmask objects are limited
to representing 63 bits as this is the largest number of bits that can be
contained in a Dart integer. If this class is used on the Web, the maximum
number of bits should be limited to 52 as this is the largest number of bits
that can be represented reliably by Javascript.

Here is a simple example showing how to use the Bitmask class with
enumerations:

```dart
import 'package:bitmask/bitmask.dart';

enum Maskbits { zero, one, two, three, four, }

void main() {
  var mask1 = Bitmask.fromList([Maskbits.one.index, 
      Maskbits.three.index],
      Maskbits.values().length);
  mask1[Maskbits.four] = true;
  var mask2 = Bitmask.fromBitmask(mask1);
  mask2.unset(Maskbits.three.index);
  print(mask1.flags.toRadixString(2)); // prints 11010
  print((mask1 & mask2).flags.toRadixString(2)); // prints 10010
  print((mask1 | mask2).flags.toRadixString(2)); // prints 11010
  print((mask1 ^ mask2).flags.toRadixString(2)); // prints 1000
  print(~mask1.flags.toRadixString(2)); // prints 101
}
```

## Installation

Add `bitmask` to you `pubspec.yaml` file.

```yaml
dependencies:
  bitmask: ^1.0.0
```

After saving the `pubspec.yaml` file, run:

```bash
dart pub update
```

Testing github pages
