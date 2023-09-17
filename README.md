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

## Status

![Dart: &check;](https://img.shields.io/badge/Dart-&check;-darkgreen)
![Flutter: &check;](https://img.shields.io/badge/Flutter-&check;-darkgreen)
![Tests: 28/28 &check;](https://img.shields.io/badge/Tests-28/28_&check;-darkgreen)
![Coverage: 100% &check;](https://img.shields.io/badge/Coverage-100%25_&check;-darkgreen)
![Documentation: not complete](https://img.shields.io/badge/Documentation-incomplete-yellow)
![Windows: not tested](https://img.shields.io/badge/Windows-%3F-yellow)
![MacOS: &check;](https://img.shields.io/badge/MacOS-&check;-darkgreen)
![Linux: not_tested](https://img.shields.io/badge/Linux-%3F-yellow)
![iOS: not tested](https://img.shields.io/badge/iOS-%3F-yellow)
![Android: not tested](https://img.shields.io/badge/Android-%3F-yellow)
![Web: not tested](https://img.shields.io/badge/Web-%3F-yellow)

? indicates that the library has not been tested on that OS.
