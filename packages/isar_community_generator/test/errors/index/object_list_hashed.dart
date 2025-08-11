// objects may not be indexed

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index(type: IndexType.hash)
  List<EmbeddedModel>? list;
}

@embedded
class EmbeddedModel {}
