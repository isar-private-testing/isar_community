// ignore_for_file: public_member_api_docs
// Web stub implementations without dart:ffi dependencies

import 'dart:async';
import 'dart:collection';

import 'package:isar_community/isar.dart';
import 'package:isar_community/src/common/isar_link_base_impl.dart';

/// Web stub for IsarLink - minimal implementation for compilation
class IsarLinkImpl<OBJ> extends IsarLinkBaseImpl<OBJ> with IsarLink<OBJ> {
  OBJ? _value;

  @override
  bool isChanged = false;

  @override
  bool isLoaded = false;

  @override
  OBJ? get value => _value;

  @override
  set value(OBJ? value) {
    _value = value;
    isChanged = true;
    isLoaded = true;
  }

  @override
  Future<void> load() async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void loadSync() {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<void> save() async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void saveSync() {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<void> reset() async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void resetSync() {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<void> update({
    Iterable<OBJ> link = const [],
    Iterable<OBJ> unlink = const [],
    bool reset = false,
  }) async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void updateSync({
    Iterable<OBJ> link = const [],
    Iterable<OBJ> unlink = const [],
    bool reset = false,
  }) {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Id Function(OBJ) get getId => (_) {
        throw UnsupportedError('Isar web support is not available');
      };
}

/// Web stub for IsarLinks - minimal implementation for compilation
class IsarLinksImpl<OBJ> extends IsarLinkBaseImpl<OBJ>
    with IsarLinks<OBJ>, SetMixin<OBJ> {
  final Set<OBJ> _objects = <OBJ>{};

  @override
  bool isLoaded = false;

  @override
  bool get isChanged => false;

  @override
  Future<void> load({bool overrideChanges = false}) async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void loadSync({bool overrideChanges = false}) {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<void> save() async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void saveSync() {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Future<void> reset() async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void resetSync() {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  bool add(OBJ value) => _objects.add(value);

  @override
  bool contains(Object? element) => _objects.contains(element);

  @override
  Iterator<OBJ> get iterator => _objects.iterator;

  @override
  int get length => _objects.length;

  @override
  OBJ? lookup(Object? element) {
    return _objects.lookup(element as OBJ);
  }

  @override
  bool remove(Object? value) => _objects.remove(value);

  @override
  Set<OBJ> toSet() => Set.from(_objects);

  @override
  void clear() => _objects.clear();

  @override
  Future<void> update({
    Iterable<OBJ> link = const [],
    Iterable<OBJ> unlink = const [],
    bool reset = false,
  }) async {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  void updateSync({
    Iterable<OBJ> link = const [],
    Iterable<OBJ> unlink = const [],
    bool reset = false,
  }) {
    throw UnsupportedError('Isar web support is not available');
  }

  @override
  Id Function(OBJ) get getId => (_) {
        throw UnsupportedError('Isar web support is not available');
      };
}