// only string lists may have hashed elements

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index(type: IndexType.hashElements)
  List<int>? list;
}
