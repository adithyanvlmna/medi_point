import 'package:intl/intl.dart';
String formatDate(DateTime? dateTime) {
  if (dateTime == null) return '';
  return DateFormat('dd/MM/yyyy').format(dateTime);
}





String formatSelectedDateTimeFromSingle({
  required String dateStr,      
  required String hourPeriod,   
  required String minuteStr,   
}) {
 
  DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);

  
  List<String> parts = hourPeriod.split(" ");
  String hourStr = parts[0];        
  String periodStr = parts[1];      

  
  int hour = int.parse(hourStr);
  int minute = int.parse(minuteStr);

  
  if (periodStr == 'PM' && hour != 12) {
    hour += 12;
  } else if (periodStr == 'AM' && hour == 12) {
    hour = 0;
  }

  DateTime fullDateTime = DateTime(date.year, date.month, date.day, hour, minute);

  return DateFormat('dd/MM/yyyy - hh:mm a').format(fullDateTime);
}
