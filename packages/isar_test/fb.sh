#!/bin/bash

fvm flutter clean && fvm flutter packages pub get && fvm flutter pub run build_runner build --delete-conflicting-outputs

fvm dart tool/generate_long_double_test.dart
fvm dart tool/generate_all_tests.dart

fvm flutter pub run build_runner build
