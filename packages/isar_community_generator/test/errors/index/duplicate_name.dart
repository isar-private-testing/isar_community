// same name

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index(name: 'myindex')
  String? prop1;

  @Index(name: 'myindex')
  String? prop2;
}
