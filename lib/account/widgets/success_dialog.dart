import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Transparent to show just the card
      elevation: 0,
       child: Container(
         width: 200, // Fixed width for square-ish look
         height: 200,
         padding: const EdgeInsets.all(20),
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(20),
           boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
           ]
         ),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              const Icon(Icons.check, size: 60, color: Color(0xFFA51C30)), // Main red check
              const SizedBox(height: 20),
              Text(
                "Đã lưu thay đổi",
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  fontSize: 18,
                  color: const Color(0xFFA51C30),
                  fontWeight: FontWeight.bold,
                ),
              ),
           ],
         ),
       ),
    );
  }
}
