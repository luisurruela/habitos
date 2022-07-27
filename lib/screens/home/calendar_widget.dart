import 'package:flutter/material.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:habitos/theme/theme.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WeeklyDatePicker(
      backgroundColor: AppTheme.primary,
      enableWeeknumberText: false,
      digitsColor: Colors.white,
      selectedDigitColor: Colors.black,
      weekdayTextColor: Colors.white,
      selectedBackgroundColor: AppTheme.secondary,
      weekdays: const ["M", "T", "W", "T", "F", "S", "S"],
      selectedDay: _selectedDay, // DateTime
      changeDay: (value) => setState(() {
        _selectedDay = value;
      }),
    );
  }
}
