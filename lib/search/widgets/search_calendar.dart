import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCalendar extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime?, DateTime?) onRangeSelected;

  const SearchCalendar({
    super.key, 
    this.startDate,
    this.endDate,
    required this.onRangeSelected,
  });

  @override
  State<SearchCalendar> createState() => _SearchCalendarState();
}

class _SearchCalendarState extends State<SearchCalendar> {
  late DateTime _focusedMonth;

  @override
  void initState() {
    super.initState();
    _focusedMonth = widget.startDate ?? DateTime.now();
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
    return DateTime(date.year, date.month, 1).weekday - 1;
  }
  
  void _onDateTap(DateTime date) {
     if (widget.startDate == null || (widget.startDate != null && widget.endDate != null)) {
       // Start fresh selection
       widget.onRangeSelected(date, null);
     } else if (widget.startDate != null && widget.endDate == null) {
       // Selecting end date?
       if (date.isBefore(widget.startDate!)) {
         // If selected date is before start date, treat as new start date
         widget.onRangeSelected(date, null);
       } else {
         // Valid end date
         widget.onRangeSelected(widget.startDate, date);
       }
     }
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
            Column(
              children: [
                Text(
                  "Tháng ${_focusedMonth.month}, ${_focusedMonth.year}",
                  style: GoogleFonts.josefinSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Hôm nay: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  style: GoogleFonts.josefinSans(
                    fontSize: 12,
                    color: const Color(0xFF013aad),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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

        // Grid
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
            
            bool isStart = widget.startDate != null && 
                           widget.startDate!.year == date.year && 
                           widget.startDate!.month == date.month && 
                           widget.startDate!.day == date.day;
            
            bool isEnd = widget.endDate != null && 
                           widget.endDate!.year == date.year && 
                           widget.endDate!.month == date.month && 
                           widget.endDate!.day == date.day;
            
            bool inRange = false;
            if (widget.startDate != null && widget.endDate != null) {
               inRange = date.isAfter(widget.startDate!) && date.isBefore(widget.endDate!);
               // Fix edge case logic if needed, but isAfter/isBefore usually strict. 
               // Actually for day precision better compare timestamps or add duration.
               // Simple: 
               if (!isStart && !isEnd) {
                  inRange = date.isAfter(widget.startDate!) && date.isBefore(widget.endDate!);
               }
            }

            return GestureDetector(
              onTap: () => _onDateTap(date),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8),
                  // Range styling
                  color: (isStart || isEnd) 
                          ? const Color(0xFF013aad) 
                          : (inRange ? const Color(0xFF013aad).withValues(alpha: 0.1) : Colors.transparent),
                  // border: (isStart || isEnd) ? Border.all(color: const Color(0xFF013aad), width: 1.5) : null,
                ),
                child: Text(
                  "$day",
                  style: GoogleFonts.josefinSans(
                    fontWeight: (isStart || isEnd) ? FontWeight.bold : FontWeight.normal,
                    color: (isStart || isEnd) ? Colors.white : Colors.black87,
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
