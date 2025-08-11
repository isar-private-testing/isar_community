// list<double> may must not be hashed

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index(type: IndexType.hash)
  List<double>? list;
}
