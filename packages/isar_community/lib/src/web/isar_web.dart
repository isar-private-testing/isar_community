// ignore_for_file: public_member_api_docs
// Web stub implementation for inspector compatibility

import 'dart:async';

import 'package:isar_community/isar.dart';

// Web platform constants - use safe JavaScript integer limits
const int isarMinId = 1;
const int isarMaxId = 9007199254740991; // max safe JS integer
const int isarAutoIncrementId = -2147483648; // min int32

// Web platform type alias
typedef IsarAbi = String;

/// Web stub for Isar - inspector compilation only
class IsarWeb extends Isar {
  IsarWeb._(String name) : super(name);

  @override
  String? get directory => null;

  @override
  Future<T> txn<T>(Future<T> Function() callback) async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<T> writeTxn<T>(Future<T> Function() callback,
      {bool silent = false}) async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  T txnSync<T>(T Function() callback) {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  T writeTxnSync<T>(T Function() callback, {bool silent = false}) {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<int> getSize(
      {bool includeIndexes = false, bool includeLinks = false}) async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  int getSizeSync({bool includeIndexes = false, bool includeLinks = false}) {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<void> copyToFile(String targetPath) async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<void> verify() async {
    throw UnsupportedError('Isar web support is not available');
  }
}

/// Web stub - throws error if called
Future<Isar> openIsar({
  required List<CollectionSchema<dynamic>> schemas,
  required String directory,
  String name = Isar.defaultName,
  int maxSizeMiB = Isar.defaultMaxSizeMiB,
  bool relaxedDurability = true,
  CompactCondition? compactOnLaunch,
}) async {
  throw UnsupportedError('Isar web support is not available');
}

/// Web stub - throws error if called
Isar openIsarSync({
  required List<CollectionSchema<dynamic>> schemas,
  required String directory,
  String name = Isar.defaultName,
  int maxSizeMiB = Isar.defaultMaxSizeMiB,
  bool relaxedDurability = true,
  CompactCondition? compactOnLaunch,
}) {
  throw UnsupportedError('Isar web support is not available');
}

/// Web stub for core binary
Future<void> initializeCoreBinary({
  Map<IsarAbi, String> libraries = const {},
  bool download = false,
}) async {
  // No-op for web
}
