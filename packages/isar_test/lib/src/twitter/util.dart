import 'package:dart_mappable/dart_mappable.dart';
import 'package:intl/intl.dart';

DateTime? convertTwitterDateTime(String? twitterDateString) {
  if (twitterDateString == null) {
    return null;
  }

  try {
    return DateTime.parse(twitterDateString);
  } catch (e) {
    try {
      final dateString = formatTwitterDateString(twitterDateString);
      return DateFormat('E MMM dd HH:mm:ss yyyy', 'en_US')
          .parse(dateString, true);
    } catch (e) {
      return null;
    }
  }
}

String formatTwitterDateString(String twitterDateString) {
  final sanitized = twitterDateString.split(' ')
    ..removeWhere((part) => part.startsWith('+'));

  return sanitized.join(' ');
}

// Custom hook for converting Twitter date strings to DateTime
class DateTimeFromStringHook extends MappingHook {
  const DateTimeFromStringHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return convertTwitterDateTime(value);
    }
    return value;
  }
}
