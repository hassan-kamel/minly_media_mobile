import 'package:intl/intl.dart';

String getTime(String dateString) {
  DateTime date = DateTime.parse(dateString);
  DateTime now = DateTime.now();

  Duration difference = now.difference(date);
  int diffInSeconds = difference.inSeconds;

  if (diffInSeconds < 60) {
    return "just now";
  } else if (diffInSeconds < 3600) {
    int minutes = (diffInSeconds / 60).floor();
    return "${-minutes} minute${minutes != 1 ? 's' : ''} ago";
  } else if (diffInSeconds < 86400) {
    int hours = (diffInSeconds / 3600).floor();
    return "${-hours} hour${hours != 1 ? 's' : ''} ago";
  } else {
    return DateFormat('MMM d, h:mm a').format(date);
  }
}
