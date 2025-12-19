import 'package:flutter/material.dart';
import 'package:ticketcon/login_and_register/auth/forgot_password/reset_password_screen.dart';
import 'package:ticketcon/widgets/custom_button.dart';
import 'package:ticketcon/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpSuccessScreen extends StatefulWidget {
  const OtpSuccessScreen({super.key});

  @override
  State<OtpSuccessScreen> createState() => _OtpSuccessScreenState();
}

class _OtpSuccessScreenState extends State<OtpSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
        );
      }
    });
  }

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
      body: Stack(
        children: [
          // Background content (Dimmed)
           Padding(
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
                  hintText: '......', 
                ),
                 const SizedBox(height: 10),
                 Align(
                  alignment: Alignment.centerRight,
                  child: Text("Gửi lại mã (5s)", style: GoogleFonts.poppins(color: Colors.grey)),
                ),
                 const SizedBox(height: 30),
                 CustomButton(text: "Xác nhận", backgroundColor: const Color(0xFF1E3A8A), onPressed: (){})
              ],
            ),
          ),
          Container(color: Colors.black54), // Overlay

          // Success Dialog
          Center(
            child: Container(
              width: 150, // Square-ish look
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                   // Checkmark Icon
                    // The icon in design is a red checkmark path.
                    // Keep existing but change color to Red (0xFFA51C30)
                   const Icon(Icons.check, color: Color(0xFFA51C30), size: 50),
                   
                   const SizedBox(height: 20),
                   Text(
                     "Xác minh thành công",
                     style: GoogleFonts.poppins(
                       fontSize: 12,
                       fontWeight: FontWeight.bold, // Bold
                       color: const Color(0xFFA51C30), // Red
                     ),
                     textAlign: TextAlign.center,
                   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
