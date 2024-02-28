import 'package:intl/intl.dart';

class ChooseDateVO {
  String date;

  bool isSelected;

  ChooseDateVO(this.date, this.isSelected);

  //date format 1
  String dateFormatOne() {
    final DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  // Get the month name
  String getMonthName() {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('MMMM').format(dateTime);
  }

  // Get the day of the month
  String getDayOfMonth() {
    final DateTime dateTime = DateTime.parse(date);
    return DateFormat('d').format(dateTime);
  }

  // Get a string indicating if the date is today, tomorrow, or a day of the week
  String getRelativeDay() {
    final DateTime dateTime = DateTime.parse(date);
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    if (dateTime.year == today.year &&
        dateTime.month == today.month &&
        dateTime.day == today.day) {
      return 'Today';
    } else if (dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEE')
          .format(dateTime); // Return day abbreviation like 'Mon', 'Tue', etc.
    }
  }
}
