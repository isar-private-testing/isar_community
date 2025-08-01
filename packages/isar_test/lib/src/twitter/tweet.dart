import 'package:dart_mappable/dart_mappable.dart';
import 'package:isar_community/isar.dart';
import 'package:isar_test/src/twitter/entities.dart';
import 'package:isar_test/src/twitter/geo.dart';
import 'package:isar_test/src/twitter/media.dart';
import 'package:isar_test/src/twitter/user.dart';
import 'package:isar_test/src/twitter/util.dart';

part 'tweet.mapper.dart';

@MappableClass()
@collection
class Tweet with TweetMappable {
  Tweet({
    this.isarId,
    this.createdAt,
    this.idStr,
    this.source,
    this.truncated,
    this.inReplyToStatusIdStr,
    this.inReplyToUserIdStr,
    this.inReplyToScreenName,
    this.user,
    this.coordinates,
    this.place,
    this.quotedStatusIdStr,
    this.isQuoteStatus,
    this.quoteCount,
    this.replyCount,
    this.retweetCount,
    this.favoriteCount,
    this.entities,
    this.extendedEntities,
    this.favorited,
    this.retweeted,
    this.possiblySensitive,
    this.possiblySensitiveAppealable,
    this.currentUserRetweet,
    this.lang,
    this.quotedStatusPermalink,
    this.fullText,
    this.displayTextRange,
  });

  Id? isarId;

  @MappableField(hook: DateTimeFromStringHook())
  DateTime? createdAt;

  String? idStr;

  String? source;

  bool? truncated;

  String? inReplyToStatusIdStr;

  String? inReplyToUserIdStr;

  String? inReplyToScreenName;

  User? user;

  Coordinates? coordinates;

  Place? place;

  String? quotedStatusIdStr;

  bool? isQuoteStatus;

  int? quoteCount;

  int? replyCount;

  int? retweetCount;

  int? favoriteCount;

  Entities? entities;

  Entities? extendedEntities;

  bool? favorited;

  bool? retweeted;

  bool? possiblySensitive;

  bool? possiblySensitiveAppealable;

  CurrentUserRetweet? currentUserRetweet;

  String? lang;

  QuotedStatusPermalink? quotedStatusPermalink;

  String? fullText;

  List<int>? displayTextRange;
}

@MappableClass()
@embedded
class CurrentUserRetweet with CurrentUserRetweetMappable {
  CurrentUserRetweet({
    this.idStr,
  });

  String? idStr;
}

@MappableClass()
@embedded
class QuotedStatusPermalink with QuotedStatusPermalinkMappable {
  QuotedStatusPermalink({
    this.url,
    this.expanded,
    this.display,
  });

  String? url;

  String? expanded;

  String? display;
}
