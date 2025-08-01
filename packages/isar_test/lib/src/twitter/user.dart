import 'package:isar_community/isar.dart';
import 'package:isar_test/src/twitter/entities.dart';
import 'package:isar_test/src/twitter/util.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'user.g.dart';
part 'user.mapper.dart';

@MappableClass()
@embedded
class User with UserMappable {
  User({
    this.idStr,
    this.name,
    this.screenName,
    this.location,
    this.url,
    this.entities,
    this.description,
    this.protected,
    this.verified,
    this.followersCount,
    this.friendsCount,
    this.listedCount,
    this.favoritesCount,
    this.statusesCount,
    this.createdAt,
    this.profileBannerUrl,
    this.profileImageUrlHttps,
    this.defaultProfile,
    this.defaultProfileImage,
    this.withheldInCountries,
    this.withheldScope,
  });

  String? idStr;

  String? name;

  String? screenName;

  String? location;

  String? url;

  UserEntities? entities;

  String? description;

  bool? protected;

  bool? verified;

  int? followersCount;

  int? friendsCount;

  int? listedCount;

  int? favoritesCount;

  int? statusesCount;

  @MappableField(hook: DateTimeFromStringHook())
  DateTime? createdAt;

  String? profileBannerUrl;

  String? profileImageUrlHttps;

  bool? defaultProfile;

  bool? defaultProfileImage;

  List<String>? withheldInCountries;

  String? withheldScope;
}

@MappableClass()
@embedded
class UserEntities with UserEntitiesMappable {
  UserEntities({
    this.url,
    this.description,
  });

  UserEntityUrl? url;

  UserEntityUrl? description;
}

@MappableClass()
@embedded
class UserEntityUrl with UserEntityUrlMappable {
  UserEntityUrl({
    this.urls,
  });

  List<Url>? urls;
}
