import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyTicketState extends StatelessWidget {
  const EmptyTicketState({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
        child: Column(
          children: [
             // Illustration
             // Using a placeholder container for the circular illustration
             Container(
               height: 180,
               width: 180,
               decoration: const BoxDecoration(
                 shape: BoxShape.circle,
                 color: Color(0xFFE3F2FD), // Light blue bg
               ),
               child: const Center(
                 // Replace with actual asset: Image.asset('assets/images/empty_ticket_illustration.png')
                 child: Icon(Icons.confirmation_number_outlined, size: 80, color: Color(0xFF013aad)),
               ),
             ),
             const SizedBox(height: 20),
             Text(
               "Bạn chưa có vé nào cả !",
               style: GoogleFonts.josefinSans(
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
                 color: const Color(0xFFB71C1C), // Red color
               ),
             ),
             const SizedBox(height: 20),
             ElevatedButton(
               onPressed: () {
                 // Action to buy ticket
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: const Color(0xFF013aad),
                 padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                 ),
                 elevation: 5,
               ),
               child: Text(
                 "Mua vé ngay",
                 style: GoogleFonts.josefinSans(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                   color: Colors.white,
                 ),
               ),
             ),
             const SizedBox(height: 30),
             const Divider(thickness: 1, color: Colors.grey),
             const SizedBox(height: 20),
             Text(
               "Có thể bạn cũng thích",
               style: GoogleFonts.josefinSans(
                 fontSize: 18,
                 color: Colors.grey[700],
                 fontWeight: FontWeight.w600,
               ),
             ),
             const SizedBox(height: 20),
             // Horizontal Suggestion List
             SizedBox(
               height: 250,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 children: [
                   _buildSuggestionCard(
                     title: 'ANH TRAI "SAY HI" 2025 CONCERT',
                     date: '27 Tháng 12, 2025',
                     imagePath: 'assets/images/ticket_banner_1.jpg',
                   ),
                   _buildSuggestionCard(
                     title: 'ANH TRAI "SAY HI" 2025 CONCERT',
                     date: '27 Tháng 12, 2025',
                     imagePath: 'assets/images/ticket_banner_2.jpg',
                   ),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard({required String title, required String date, required String imagePath}) {
    return Container(
      width: 220, // Fixed width for horizontal scrolling
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // No shadow in design? Or subtle.
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              height: 120, // Half height
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300], height: 120),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              title,
              style: GoogleFonts.josefinSans(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: const Color(0xFF013aad), // Blue title
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 12, color: Color(0xFFB71C1C)), // Red icon
                const SizedBox(width: 4),
                Text(
                  date,
                  style: GoogleFonts.josefinSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: const Color(0xFFB71C1C), // Red text
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
