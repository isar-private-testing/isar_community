// same name

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  String? prop1;

  @Name('prop1')
  String? prop2;
}
