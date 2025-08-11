// must not be late

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  late IsarLink<Model2> link;
}

@collection
class Model2 {
  Id? id;
}
