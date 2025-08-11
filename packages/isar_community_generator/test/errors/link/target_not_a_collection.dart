// link target is not annotated with @collection

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  final IsarLink<int> link = IsarLink();
}
