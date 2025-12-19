import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/account/widgets/success_dialog.dart';

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

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: GoogleFonts.josefinSans(),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.josefinSans(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // Widened
          border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15), // Radius 15
             borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(15), // Radius 15
             borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildTextField("Nhập email hoặc SĐT", _emailController),
            _buildTextField("Nhập mật khẩu mới", _newPassController),
            _buildTextField("Xác nhận mật khẩu mới", _confirmPassController),
            
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
                onPressed: () {
                   showDialog(
                     context: context,
                     barrierDismissible: false,
                     builder: (dialogContext) {
                       Future.delayed(const Duration(milliseconds: 1000), () {
                         if (dialogContext.mounted) {
                           Navigator.of(dialogContext).pop(); // Close Dialog
                           if (context.mounted) {
                              Navigator.of(context).pop(); // Close Screen
                           }
                         }
                       });
                       return const PopScope(
                         canPop: false,
                         child: SuccessDialog(),
                       );
                     },
                   );
                },
                style: ElevatedButton.styleFrom(
                   backgroundColor: const Color(0xFF013aad),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                   padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
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
