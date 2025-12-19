import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketcon/search/widgets/search_calendar.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _selectedCategory = "Nhạc sống";
  String _selectedTime = "Hôm nay";
  DateTime? _selectedDate;

  final List<String> categories = ["Nhạc sống", "Thể thao", "Khác"];
  final List<String> timeOptions = ["Tất cả các ngày", "Hôm nay", "Tháng này"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85, // Occupy most of the screen like design
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               const SizedBox(width: 24), // Spacer for centering
               Text(
                "Bộ lọc",
                style: GoogleFonts.josefinSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF013aad), size: 28),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const SizedBox(height: 20),
                  // Categories
                  Text(
                    "Thể loại",
                    style: GoogleFonts.josefinSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: categories.map((category) {
                      final isSelected = _selectedCategory == category;
                      return ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                           setState(() {
                             _selectedCategory = category;
                           });
                        },
                        selectedColor: Colors.white,
                        backgroundColor: Colors.white,
                        labelStyle: GoogleFonts.josefinSans(
                          color: isSelected ? const Color(0xFF013aad) : Colors.grey,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected ? const Color(0xFF013aad) : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),

                   const SizedBox(height: 24),
                  // Time
                  Text(
                    "Chọn thời gian",
                    style: GoogleFonts.josefinSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                       color: Colors.black87,
                    ),
                  ),
                   const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: timeOptions.map((option) {
                      final isSelected = _selectedTime == option;
                       return ChoiceChip(
                        label: Text(option),
                        selected: isSelected,
                        onSelected: (selected) {
                           setState(() {
                             _selectedTime = option;
                           });
                        },
                        selectedColor: Colors.white,
                        backgroundColor: Colors.white,
                         labelStyle: GoogleFonts.josefinSans(
                          color: isSelected ? const Color(0xFF013aad) : Colors.grey,
                           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                             fontSize: 14
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                           side: BorderSide(
                            color: isSelected ? const Color(0xFF013aad) : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                         showCheckmark: false,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 10),

                  // Calendar
                  SearchCalendar(
                    selectedDate: _selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                        _selectedTime = ""; // Clear preset if date selected manually
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = "";
                        _selectedTime = "";
                        _selectedDate = null;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF013aad), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Thiết lập lại",
                      style: GoogleFonts.josefinSans(
                        color: const Color(0xFF013aad),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF013aad),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Áp dụng",
                      style: GoogleFonts.josefinSans(
                         color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
