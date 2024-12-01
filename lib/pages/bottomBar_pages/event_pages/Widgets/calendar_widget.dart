import 'package:bima_gyaan/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronIcon: Icon(Icons.chevron_left, color: AppColors.dark),
        rightChevronIcon: Icon(Icons.chevron_right, color: AppColors.dark),
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: AppColors.orange,
          shape: BoxShape.rectangle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.orange,
          shape: BoxShape.rectangle,
        ),
        defaultDecoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(
          color: AppColors.dark,
        ),
        defaultTextStyle: TextStyle(
          color: AppColors.dark,
        ),
        outsideDaysVisible: false,
      ),
      calendarFormat: CalendarFormat.month,
      availableGestures: AvailableGestures.none,
    );
  }
}
