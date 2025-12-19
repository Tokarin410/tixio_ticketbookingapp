import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketcon/account/screens/edit_profile_screen.dart';
import 'package:ticketcon/account/screens/payment_management_screen.dart';
import 'package:ticketcon/account/screens/reset_password_screen.dart';
import 'package:ticketcon/account/widgets/logout_dialog.dart';
import 'package:ticketcon/widgets/zigzag_clipper.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isEnglish = false;

  Widget _buildMenuItem(String title, {VoidCallback? onTap, Widget? trailing}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title, 
               style: GoogleFonts.josefinSans(fontSize: 18, color: Colors.black87),
            ),
            trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with custom ZigZag
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipPath(
                  clipper: ZigZagClipper(),
                  child: Container(
                    height: 220, // Increased height for account header
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFF013aad), // Fallback color if image is missing/loading
                      image: DecorationImage(
                        image: AssetImage("assets/images/background.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                       Container(
                        width: 100,
                        height: 100,
                         decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          image: const DecorationImage(
                             image: AssetImage("assets/images/logotixio.png"), // Fallback
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Phan Khánh Nam",
                        style: GoogleFonts.josefinSans(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 70), // Spacing for avatar overlap
            
            // Settings Group 1
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Row(
                 children: [
                   const Icon(Icons.manage_accounts, color: Colors.black),
                   const SizedBox(width: 8),
                   Text("Cài đặt tài khoản", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 18)),
                 ],
               ),
             ),
             const SizedBox(height: 8),
            _buildMenuItem("Thông tin tài khoản", onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
            }),
             _buildMenuItem("Đặt lại mật khẩu", onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ResetPasswordScreen()));
             }),

             const SizedBox(height: 20),
             
             // Settings Group 2 (Payment)
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16.0),
               child: Row(
                 children: [
                   const Icon(Icons.settings, color: Colors.black),
                   const SizedBox(width: 8),
                   Text("Cài đặt tài khoản", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 18)),
                 ],
               ),
             ),
              const SizedBox(height: 8),
             _buildMenuItem(
               "Quản lý thanh toán",
               onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentManagementScreen()));
               } 
               // No trailing, defaults to arrow
             ),
             
             const SizedBox(height: 20),
             
             // Logout 
             GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (_) => const LogoutDialog());
               },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                       const Icon(Icons.exit_to_app, color: Colors.black),
                       const SizedBox(width: 8),
                       Text("Đăng xuất", style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold)),
                       // Removed Spacer and Arrow
                    ],
                  ),
                ),
             )

          ],
        ),
      ),
    );
  }
}


