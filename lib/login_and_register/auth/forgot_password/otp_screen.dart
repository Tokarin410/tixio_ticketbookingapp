import 'package:flutter/material.dart';
import 'package:ticketcon/login_and_register/auth/forgot_password/otp_success_screen.dart';
import 'package:ticketcon/widgets/custom_button.dart';
import 'package:ticketcon/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        title: Text("Tìm tài khoản", style: GoogleFonts.poppins(color: const Color(0xFF1E3A8A), fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E3A8A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Chúng tôi đã gửi mã OTP về thuê bao (+84). Vui lòng nhập thông tin.",
              style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 30),
            const CustomTextField(
              hintText: 'Nhập mã xác minh',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Gửi lại mã (5s)", style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Xác nhận',
              backgroundColor: const Color(0xFF1E3A8A), // Blue color
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpSuccessScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
