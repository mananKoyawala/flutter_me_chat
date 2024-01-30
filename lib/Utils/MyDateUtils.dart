import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/Services/NavigatorServices.dart';

class MyDateUtils {
  static String getFormattedTime({required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(ncontext);
  }

  // for getting formatted time for sent & read
  static String getMessageTime({required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    final formattedTime = TimeOfDay.fromDateTime(sent).format(ncontext);
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedTime;
    }

    return now.year == sent.year
        ? '$formattedTime - ${sent.day} ${getMonth(sent)}'
        : '$formattedTime - ${sent.day} ${getMonth(sent)} ${sent.year}';
  }

  //get last message time
  static String getLastMessageTime(
      {required String time, required bool showYear}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return showYear
          ? 'Today at ${TimeOfDay.fromDateTime(sent).format(ncontext)}'
          : TimeOfDay.fromDateTime(sent).format(ncontext);
    }

    if (yesterday.day == sent.day &&
        yesterday.month == sent.month &&
        yesterday.year == sent.year) {
      return showYear
          ? 'Yesterday at ${TimeOfDay.fromDateTime(sent).format(ncontext)}'
          : TimeOfDay.fromDateTime(sent).format(ncontext);
    }
    return showYear
        ? '${sent.day} ${getMonth(sent)} ${sent.year}'
        : '${sent.day} ${getMonth(sent)}';
  }

  //get formatted last active time of user in chat screen
  static String getLastActiveTime({required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(ncontext);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = getMonth(time);

    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  static String getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'NA';
    }
  }
}
