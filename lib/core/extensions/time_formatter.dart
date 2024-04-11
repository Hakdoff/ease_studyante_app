import 'package:intl/intl.dart';

extension StrToTimeFormat on String {
  String parseStrToTime() {
    DateTime time = DateFormat("HH:mm:ss").parse(this);
    String formattedTime = DateFormat('ha').format(time);

    return formattedTime;
  }
}
