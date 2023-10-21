import 'package:intl/intl.dart';

String formattedDate(DateTime datetime) {
  var formatter = DateFormat('MMM-dd');
  String formattedDate = formatter.format(datetime);
  return formattedDate;
}
