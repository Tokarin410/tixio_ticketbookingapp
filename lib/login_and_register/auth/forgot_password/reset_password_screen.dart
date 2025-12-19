import 'package:flutter/material.dart';
import 'package:tixio/login_and_register/auth/forgot_password/reset_success_screen.dart';
import 'package:tixio/widgets/custom_button.dart';
import 'package:tixio/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        title: Text("Đặt lại mật khẩu", style: GoogleFonts.poppins(color: const Color(0xFF1E3A8A), fontWeight: FontWeight.bold, fontSize: 20)),
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
             const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Nhập email hoặc SĐT',
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: 'Nhập mật khẩu mới',
              obscureText: true,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              hintText: 'Xác nhận mật khẩu mới',
              obscureText: true,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: Text("Lưu mật khẩu", style: GoogleFonts.poppins(fontWeight: FontWeight.bold))),
                Switch(value: true, onChanged: (val){}, activeColor: const Color(0xFF1E3A8A)),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Xác nhận',
              backgroundColor: const Color(0xFF1E3A8A), // Blue color
              onPressed: () {
                 Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetSuccessScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
