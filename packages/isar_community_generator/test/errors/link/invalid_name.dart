// names must not be blank or start with

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Name('_link')
  final IsarLink<Model2> link = IsarLink();
}

@collection
class Model2 {
  Id? id;
}
