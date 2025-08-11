// names must not be blank or start with "_"

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Index(name: '_index')
  String? str;
}
