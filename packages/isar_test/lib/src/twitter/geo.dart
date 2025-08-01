import 'package:isar_community/isar.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'geo.g.dart';
part 'geo.mapper.dart';

@MappableClass()
@embedded
class Place with PlaceMappable {
  Place({
    this.id,
    this.url,
    this.placeType,
    this.name,
    this.fullName,
    this.countryCode,
    this.country,
  });

  String? id;

  String? url;

  @Enumerated(EnumType.name)
  PlaceType? placeType;

  String? name;

  String? fullName;

  String? countryCode;

  String? country;
}

enum PlaceType {
  admin,
  country,
  city,
  poi,
  neighborhood;
}

@MappableClass()
@embedded
class Coordinates with CoordinatesMappable {
  Coordinates({
    this.coordinates,
    this.type,
  });

  List<double>? coordinates;

  String? type;
}
