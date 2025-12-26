import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/login_and_register/auth/login_option_screen.dart';
import 'package:tixio/services/authentication.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Oops!",
              style: GoogleFonts.josefinSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Bạn chắc chắn muốn đăng xuất chứ ?",
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
             const SizedBox(height: 24),
             Row(
               children: [
                 Expanded(
                   child: OutlinedButton(
                     onPressed: () => Navigator.pop(context),
                     style: OutlinedButton.styleFrom(
                       side: const BorderSide(color: Color(0xFF013aad), width: 1.5),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                       padding: const EdgeInsets.symmetric(vertical: 12),
                     ),
                     child: Text(
                       "Ở lại",
                       style: GoogleFonts.josefinSans(
                         color: const Color(0xFF013aad),
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(width: 16),
                 Expanded(
                   child: ElevatedButton(
                     onPressed: () async {
                       await AuthService().signOut(); // Actual logout
                       if (context.mounted) {
                           Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(builder: (context) => const LoginOptionScreen()),
                             (route) => false,
                           );
                       }
                     },
                     style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF013aad),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                     ),
                     child: Text(
                       "Đăng xuất",
                        style: GoogleFonts.josefinSans(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                 ),
               ],
             )
          ],
        ),
      ),
    );
  }
}
