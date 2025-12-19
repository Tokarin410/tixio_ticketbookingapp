import 'package:flutter/material.dart';
import 'package:ticketcon/login_and_register/auth/login_screen.dart';
import 'package:ticketcon/login_and_register/auth/register_screen.dart';
import 'package:ticketcon/widgets/custom_button.dart';
import 'package:ticketcon/widgets/tixio_logo.dart';
import 'package:ticketcon/widgets/zigzag_background.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginOptionScreen extends StatelessWidget {
  const LoginOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),
            // Logo
            const TixioLogo(size: 220),
            const Spacer(),
            // Login Button
            CustomButton(
              text: 'Đăng nhập',
              backgroundColor: const Color(0xFF1E3A8A), // Dark Blue
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
             Align(
               alignment: Alignment.center,
               child: GestureDetector(
                  onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                  },
                 child: RichText(
                    text: TextSpan(
                      text: "Bạn chưa có tài khoản? ",
                      style: GoogleFonts.poppins(color: Colors.black54, fontSize: 14),
                      children: [
                        TextSpan(
                          text: "Đăng ký",
                          style: GoogleFonts.poppins(color: const Color(0xFFA51C30), fontWeight: FontWeight.bold),
                        )
                      ]
                    ),
                 ),
               ),
             ),
             const Spacer(flex: 2),
          ],
        ),
      ),

    );
  }
}
