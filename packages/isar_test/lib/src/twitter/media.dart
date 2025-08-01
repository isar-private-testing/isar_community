import 'package:isar_community/isar.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'media.g.dart';
part 'media.mapper.dart';

@MappableClass()
@embedded
class Media with MediaMappable {
  Media({
    this.displayUrl,
    this.expandedUrl,
    this.idStr,
    this.indices,
    this.mediaUrl,
    this.mediaUrlHttps,
    this.sizes,
    this.sourceStatusIdStr,
    this.type,
    this.url,
    this.videoInfo,
    this.additionalMediaInfo,
  });

  String? displayUrl;

  String? expandedUrl;

  String? idStr;

  List<int>? indices;

  String? mediaUrl;

  String? mediaUrlHttps;

  Sizes? sizes;

  String? sourceStatusIdStr;

  String? type;

  String? url;

  VideoInfo? videoInfo;

  AdditionalMediaInfo? additionalMediaInfo;
}

@MappableClass()
@embedded
class Sizes with SizesMappable {
  Sizes({
    this.thumb,
    this.medium,
    this.small,
    this.large,
  });

  Size? thumb;

  Size? medium;

  Size? small;

  Size? large;
}

@MappableClass()
@embedded
class Size with SizeMappable {
  Size({
    this.w,
    this.h,
    this.resize,
  });

  int? w;

  int? h;

  String? resize;
}

@MappableClass()
@embedded
class AdditionalMediaInfo with AdditionalMediaInfoMappable {
  AdditionalMediaInfo({
    this.title,
    this.description,
    this.embeddable,
    this.monetizable,
  });

  String? title;

  String? description;

  bool? embeddable;

  bool? monetizable;
}

@MappableClass()
@embedded
class VideoInfo with VideoInfoMappable {
  VideoInfo({
    this.aspectRatio,
    this.durationMillis,
    this.variants,
  });

  List<int>? aspectRatio;

  int? durationMillis;

  List<Variant>? variants;
}

@MappableClass()
@embedded
class Variant with VariantMappable {
  Variant({
    this.bitrate,
    this.contentType,
    this.url,
  });

  int? bitrate;

  String? contentType;

  String? url;
}
