import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketcon/login_and_register/auth/forgot_password/find_account_screen.dart';
import 'package:ticketcon/login_and_register/auth/register_screen.dart';
import 'package:ticketcon/widgets/custom_button.dart';
import 'package:ticketcon/widgets/custom_text_field.dart';
import 'package:ticketcon/widgets/social_button.dart';
import 'package:ticketcon/widgets/tixio_logo.dart';
import 'package:ticketcon/widgets/custom_button.dart';
import 'package:ticketcon/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _showPasswordError = false;
  bool _showEmailError = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      final text = _passwordController.text;
      setState(() {
         if (text.isNotEmpty && (text.length < 8 || text.length > 32)) {
           _showPasswordError = true;
         } else {
           _showPasswordError = false;
         }
      });
    });

    _emailController.addListener(() {
      final text = _emailController.text;
      if (text.isEmpty) {
        setState(() => _showEmailError = false);
        return;
      }
      
      // Validation Logic:
      // 1. Gmail: Ends with @gmail.com (or contains @gmail based on simple check, but standard is endsWith)
      // 2. Phone: Exactly 10 digits and numeric.
      bool isGmail = text.endsWith('@gmail.com');
      bool isPhone = text.length == 10 && RegExp(r'^[0-9]+$').hasMatch(text);

      setState(() {
        if (!isGmail && !isPhone) {
          _showEmailError = true;
        } else {
          _showEmailError = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Đăng nhập",
          style: GoogleFonts.poppins(
            color: const Color(0xFF1E3A8A),
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Color(0xFF1E3A8A), size: 24), // Design shows blue X in circle
              style: IconButton.styleFrom(
                   backgroundColor: const Color(0xFFE3F2FD), // Very light blue bg
                   shape: const CircleBorder(),
               ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              // No Logo in Design 2/3 for Form View
              CustomTextField(
                hintText: 'Nhập email hoặc SĐT',
                controller: _emailController,
              ),
               if (_showEmailError)
                 Padding(
                   padding: const EdgeInsets.only(left: 10, top: 4),
                   child: Text(
                     "Nhập đúng định dạng gmail (@gmail) và SĐT (10 số)", 
                     style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 10) // Should resemble "light red" as per image roughly
                   ),
                 ),

              const SizedBox(height: 16),
              CustomTextField(
                hintText: 'Nhập mật khẩu',
                obscureText: _obscurePassword,
                controller: _passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              
              // "Mật khẩu phải từ 8 - 32 kí tự" - appears in red in one of design images for input
               if (_showPasswordError) ...[
                 const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Mật khẩu phải từ 8 - 32 kí tự",
                        style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 10),
                      ),
                    ),
                  ),
               ],

               const SizedBox(height: 10),
               Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FindAccountScreen()),
                    );
                  },
                  child: Text(
                    "Quên mật khẩu?",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFA51C30), // Red color
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
               ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Tiếp tục',
                backgroundColor: const Color(0xFF1E3A8A), // Dark Blue
                onPressed: () {
                   Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                },
              ),
              const SizedBox(height: 20),
               Center(
                  child: Text(
                    "Hoặc",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFA51C30), // Red
                      fontWeight: FontWeight.w500
                    ),
                  ),
               ),
              const SizedBox(height: 20),
              SocialButton(
                text: 'Đăng nhập với Facebook',
                icon: FontAwesomeIcons.facebookF,
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              SocialButton(
                text: 'Đăng nhập với Google',
                icon: FontAwesomeIcons.googlePlusG,
                onPressed: () {},
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản? ",
                    style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Đăng ký",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFA51C30), // Red
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
               const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


