import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCalendar extends StatefulWidget {
  final DateTime?  selectedDate;
  final Function(DateTime) onDateSelected;

  const SearchCalendar({
    super.key, 
    this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<SearchCalendar> createState() => _SearchCalendarState();
}

class _SearchCalendarState extends State<SearchCalendar> {
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _focusedMonth = widget.selectedDate ?? DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  int _daysInMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }

  int _firstDayOffset(DateTime date) {
    // 1 = Mon, 7 = Sun. content starts at Mon.
    // DateTime.weekday: Mon=1, ... Sun=7.
    // We want Monday to be index 0. So subtract 1.
    return DateTime(date.year, date.month, 1).weekday - 1;
  }

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = _daysInMonth(_focusedMonth);
    final int firstDayOffset = _firstDayOffset(_focusedMonth);
    final int totalCells = daysInMonth + firstDayOffset;

    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.blue),
              onPressed: _previousMonth,
            ),
            Text(
              "Tháng ${_focusedMonth.month}, ${_focusedMonth.year}",
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.blue),
              onPressed: _nextMonth,
            ),
          ],
        ),
        
        // Days of Week
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ["T2", "T3", "T4", "T5", "T6", "T7", "CN"]
                .map((day) => Text(
                      day,
                      style: GoogleFonts.josefinSans(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ))
                .toList(),
          ),
        ),

        // Settings for grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalCells > 35 ? 42 : 35, // Ensure consistent height mostly
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            if (index < firstDayOffset || index >= totalCells) {
              return const SizedBox();
            }

            final day = index - firstDayOffset + 1;
            final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
            final isSelected = widget.selectedDate != null &&
                widget.selectedDate!.year == date.year &&
                widget.selectedDate!.month == date.month &&
                widget.selectedDate!.day == date.day;

            return GestureDetector(
              onTap: () => widget.onDateSelected(date),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected ? Border.all(color: const Color(0xFF013aad), width: 1.5) : null,
                  color: isSelected ? Colors.transparent : Colors.transparent,
                ),
                child: Text(
                  "$day",
                  style: GoogleFonts.josefinSans(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? const Color(0xFF013aad) : Colors.black87,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
