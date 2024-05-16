import 'package:intl/intl.dart';

String formatTransactionDate(String transactionDate) {
  DateTime parsedDate = DateTime.parse(transactionDate);
  String formattedDate = DateFormat.yMMMMd().add_jm().format(parsedDate);
  return formattedDate;
}


Map<String, String> formatTransactionDateMap(String transactionDate) {
  DateTime parsedDate = DateTime.parse(transactionDate);
  
  String day = DateFormat.E().format(parsedDate); // Day (e.g., Mon)
  String date = DateFormat.d().format(parsedDate); // Date (e.g., 05)
  String month = DateFormat.MMMM().format(parsedDate); // Month (e.g., May)
  String year = DateFormat.y().format(parsedDate); // Year (e.g., 2024)
  String time = DateFormat.jm().format(parsedDate); // Time (e.g., 11:56 AM)

  return {
    'day': day,
    'date': date,
    'month': month,
    'year': year,
    'time': time,
  };
}

// void main() {
//   print(formatTransactionDateMap("2024-05-13T12:47:09"));
// }
