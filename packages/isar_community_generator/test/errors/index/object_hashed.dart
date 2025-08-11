// objects may not be indexed

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index()
  EmbeddedModel? obj;
}

@embedded
class EmbeddedModel {}
