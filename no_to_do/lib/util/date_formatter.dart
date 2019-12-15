import 'package:intl/intl.dart' as intl;

String dateFormatted(){
  var now = DateTime.now();
  var formatter = intl.DateFormat("EEE, MMM d, ''yy");
  String formatted = formatter.format(now);

  return formatted;
}