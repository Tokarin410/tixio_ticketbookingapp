import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/account/widgets/success_dialog.dart';

import 'package:tixio/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  bool _savePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      _emailController.text = user.email!;
    }
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: GoogleFonts.josefinSans(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.josefinSans(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15), 
             borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15), 
             borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Future<void> _handleReset() async {
    final email = _emailController.text.trim();
    final newPass = _newPassController.text;
    final confirmPass = _confirmPassController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vui lòng nhập email")));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      // CASE 1: Logged In User -> Update Password directly
      if (user != null && user.email == email) {
         if (newPass.isEmpty || newPass.length < 6) {
            throw FirebaseAuthException(code: 'weak-password', message: 'Mật khẩu phải từ 6 kí tự.');
         }
         if (newPass != confirmPass) {
            throw FirebaseAuthException(code: 'password-mismatch', message: 'Mật khẩu xác nhận không khớp.');
         }
         
         await user.updatePassword(newPass);
         // Success Dialog
         if (mounted) _showSuccess();
      } 
      // CASE 2: Not Logged In or Email mismatch (Forgot Password Flow)
      else {
         // Standard Firebase Reset (Sends Email)
         // Since we can't set password directly without Auth credential.
         await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
         if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đã gửi email đặt lại mật khẩu. Vui lòng kiểm tra hộp thư.")),
            );
            Navigator.pop(context);
         }
      }
    } on FirebaseAuthException catch (e) {
      String message = "Lỗi: ${e.message}";
      if (e.code == 'requires-recent-login') {
        message = "Vui lòng đăng nhập lại để đổi mật khẩu.";
      }
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lỗi: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (dialogContext.mounted) {
            Navigator.of(dialogContext).pop(); 
            if (context.mounted) {
               Navigator.of(context).pop(); 
            }
          }
        });
        return const PopScope(
          canPop: false,
          child: SuccessDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        title: Text(
          "Đặt lại mật khẩu",
          style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        elevation: 0,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( // Changed to ScrollView to avoid overflow
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildTextField("Nhập email hoặc SĐT", _emailController),
            _buildTextField("Nhập mật khẩu mới", _newPassController, isPassword: true), // Added obscure
            _buildTextField("Xác nhận mật khẩu mới", _confirmPassController, isPassword: true), // Added obscure
            
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Lưu mật khẩu", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold)),
                Switch(
                  value: _savePassword, 
                  onChanged: (v) => setState(() => _savePassword = v),
                  activeColor: const Color(0xFF013aad),
                )
              ],
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleReset, // Disable loop
                style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF013aad),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                   padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text(
                  "Xác nhận", 
                  style: GoogleFonts.josefinSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
