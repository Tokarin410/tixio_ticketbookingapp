import 'package:flutter/material.dart';
import 'package:tixio/login_and_register/auth/login_screen.dart';
import 'package:tixio/widgets/custom_button.dart';
import 'package:tixio/widgets/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetSuccessScreen extends StatefulWidget {
  const ResetSuccessScreen({super.key});

  @override
  State<ResetSuccessScreen> createState() => _ResetSuccessScreenState();
}

class _ResetSuccessScreenState extends State<ResetSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Navigate back to Login Option or Main Login
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

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
      body: Stack(
        children: [
          // Background content (Dimmed) - Reuse UI of Reset Password Screen roughly to look like overlay?
          // Or just standard dimmed background with same fields but "disabled" look?
          // I'll just simulate the background fields as done in previous implementation but using the new colors.
           Padding(
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(color: Colors.black54), // Overlay

          // Success Dialog
          Center(
            child: Container(
              width: 150,
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
                   const Icon(Icons.check, color: Color(0xFFA51C30), size: 50),
                   
                   const SizedBox(height: 20),
                   Text(
                     "Đã lưu thay đổi",
                     style: GoogleFonts.poppins(
                       fontSize: 12,
                       fontWeight: FontWeight.bold,
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
