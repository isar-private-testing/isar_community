// ids cannot be indexed

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index(composite: [CompositeIndex('id')])
  String? str;
}
