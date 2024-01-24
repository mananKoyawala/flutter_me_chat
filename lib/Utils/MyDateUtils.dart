import 'package:me_chat/Packages/Package_Export.dart';
import 'package:me_chat/Utils/Services/NavigatorServices.dart';

class MyDateUtils {
  static String getFormattedTime({required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(ncontext);
  }
}
