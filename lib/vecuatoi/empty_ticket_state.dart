import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/homepage/home_screen.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';

class EmptyTicketState extends StatelessWidget {
  const EmptyTicketState({super.key});

  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30), // Vertical reduced from 40
         child: Column(
           children: [
              // Illustration
              Container(
                height: 150, // Reduced from 180
                width: 150, // Reduced from 180
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE3F2FD), 
                ),
                child: const Center(
                  child: Icon(Icons.confirmation_number_outlined, size: 70, color: Color(0xFF013aad)), // Reduced size
                ),
              ),
              const SizedBox(height: 15), // Reduced from 20
              Text(
                "Bạn chưa có vé nào cả !",
                style: GoogleFonts.josefinSans(
                  fontSize: 16, // Reduced from 18
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFB71C1C), 
                ),
              ),
              const SizedBox(height: 15), // Reduced from 20
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF013aad),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12), // Reduced padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  "Mua vé ngay",
                  style: GoogleFonts.josefinSans(
                    fontSize: 16, // Reduced from 18
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 25), // Reduced from 30
              const Divider(thickness: 1, color: Colors.grey),
              const SizedBox(height: 15), // Reduced from 20
              Text(
                "Có thể bạn cũng thích",
                style: GoogleFonts.josefinSans(
                  fontSize: 16, // Reduced from 18
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15), // Reduced from 20
              // Static Row Suggestion List
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 0), // Already inside padded parent? Parent has 16 padding.
                 child: Row(
                   children: [
                     Expanded(
                       child: _buildSuggestionCard(
                         context,
                         title: 'ANH TRAI "SAY HI" 2025 CONCERT',
                         date: '27 Tháng 12, 2025',
                         imagePath: 'assets/images/Poster ngang/ATSH.png',
                         margin: const EdgeInsets.only(right: 8), // Add margin to first item
                       ),
                     ),
                     Expanded(
                       child: _buildSuggestionCard(
                         context,
                         title: 'ANH TRAI "SAY HI" 2025 CONCERT',
                         date: '27 Tháng 12, 2025',
                         imagePath: 'assets/images/Poster ngang/ATSH.png',
                         margin: const EdgeInsets.only(left: 8), // Add margin to second item
                       ),
                     ),
                   ],
                 ),
               ),
           ],
         ),
       ),
     );
   }
 
   Widget _buildSuggestionCard(BuildContext context, {required String title, required String date, required String imagePath, required EdgeInsets margin}) {
     return GestureDetector(
       onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => const ThongTinSuKienScreen()));
       },
       child: Container(
         // width removed, relying on Expanded parent
         margin: margin,
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(16),
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(16),
               child: Image.asset(
                 imagePath,
                 height: 110, // Reduced from 120
                 width: double.infinity,
                 fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300], height: 110),
               ),
             ),
             const SizedBox(height: 8),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 4.0),
               child: Text(
                 title,
                 style: GoogleFonts.josefinSans(
                   fontWeight: FontWeight.bold,
                   fontSize: 12, // Reduced from 13
                   color: const Color(0xFF013aad), 
                 ),
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
             const SizedBox(height: 4),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 4.0),
               child: Row(
                 children: [
                   const Icon(Icons.calendar_today, size: 11, color: Color(0xFFA51C30)), // Reduced size
                   const SizedBox(width: 4),
                   Text(
                     date,
                     style: GoogleFonts.josefinSans(
                       fontWeight: FontWeight.bold,
                       fontSize: 9, // Reduced from 10
                       color: const Color(0xFFA51C30), 
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     );
   }
 }
