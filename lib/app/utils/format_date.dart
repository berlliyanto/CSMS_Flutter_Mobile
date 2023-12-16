import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date == null) {
    return '-';
  } else {
    return DateFormat('dd MMMM yyyy - HH:mm:ss').format(date);
  }
}
