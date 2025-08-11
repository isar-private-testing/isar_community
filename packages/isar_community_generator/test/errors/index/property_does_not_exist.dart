// property does not exist

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index(composite: [CompositeIndex('myProp')])
  String? str;
}
