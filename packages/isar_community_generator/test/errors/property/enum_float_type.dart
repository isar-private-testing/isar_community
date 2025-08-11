// unsupported enum property type

import 'package:isar_community/isar_community.dart';

@collection
class Model {
  Id? id;

  @Enumerated(EnumType.value, 'value')
  late MyEnum field;
}

enum MyEnum {
  optionA;

  final float value = 5.5;
}
