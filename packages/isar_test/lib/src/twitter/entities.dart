import 'package:isar_community/isar.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'entities.g.dart';
part 'entities.mapper.dart';

@MappableClass()
@embedded
class Entities with EntitiesMappable {
  Entities({
    this.hashtags,
    this.media,
    this.urls,
    this.userMentions,
    this.symbols,
    this.polls,
  });

  List<Hashtag>? hashtags;

  List<Media>? media;

  List<Url>? urls;

  List<UserMention>? userMentions;

  List<Symbol>? symbols;

  List<Poll>? polls;
}

@MappableClass()
@embedded
class Hashtag with HashtagMappable {
  Hashtag({
    this.indices,
    this.text,
  });

  List<int>? indices;

  String? text;
}

@MappableClass()
@embedded
class Poll with PollMappable {
  Poll({
    this.options,
    this.endDatetime,
    this.durationMinutes,
  });

  List<Option>? options;

  @MappableField(hook: DateTimeFromStringHook())
  DateTime? endDatetime;

  String? durationMinutes;
}

@MappableClass()
@embedded
class Option with OptionMappable {
  Option({
    this.position,
    this.text,
  });

  int? position;

  String? text;
}

@MappableClass()
@embedded
class Symbol with SymbolMappable {
  Symbol({
    this.indices,
    this.text,
  });

  List<int>? indices;

  String? text;
}

@MappableClass()
@embedded
class Url with UrlMappable {
  Url({
    this.displayUrl,
    this.expandedUrl,
    this.indices,
    this.url,
  });

  String? displayUrl;

  String? expandedUrl;

  List<int>? indices;

  String? url;
}

@MappableClass()
@embedded
class UserMention with UserMentionMappable {
  UserMention({
    this.idStr,
    this.indices,
    this.name,
    this.screenName,
  });

  String? idStr;

  List<int>? indices;

  String? name;

  String? screenName;
}
