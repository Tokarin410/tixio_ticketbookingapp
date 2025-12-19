import 'package:flutter/material.dart';
import 'package:ticketcon/login_and_register/auth/forgot_password/otp_screen.dart';
import 'package:ticketcon/widgets/custom_button.dart';
import 'package:ticketcon/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class FindAccountScreen extends StatelessWidget {
  const FindAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tìm tài khoản", style: GoogleFonts.poppins(color: const Color(0xFF1E3A8A), fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false, // Left aligned as per design 1? Actually looks standard left title in iOS style or center in Android. Design 1 shows "< Tìm tài khoản".
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
              "Để tiến hành thiết lập lại mật khẩu, chúng tôi sẽ gửi mã xác nhận về email hoặc số điện thoại của bạn để xác minh.\nVui lòng nhập thông tin.",
              style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
            ),
             const SizedBox(height: 30),
            const CustomTextField(
              hintText: 'Nhập email hoặc SĐT',
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Tiếp tục',
              backgroundColor: const Color(0xFF1E3A8A), // Blue color
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OtpScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
