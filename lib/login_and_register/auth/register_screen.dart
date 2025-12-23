import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Added
import 'package:tixio/login_and_register/auth/login_screen.dart';
import 'package:tixio/widgets/custom_button.dart';
import 'package:tixio/widgets/custom_text_field.dart';
import 'package:tixio/widgets/social_button.dart'; // Added
import 'package:tixio/widgets/tixio_logo.dart';
import 'package:tixio/widgets/zigzag_background.dart';
import 'package:tixio/services/authentication.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController(); // Added
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  // Validation States
  bool _isLengthValid = false;
  bool _isUppercaseValid = false;
  bool _isSpecialValid = false;
  bool _isMatchValid = false;
  
  bool _showPassLengthError = false;
  bool _showConfirmPassLengthError = false;
  bool _showEmailError = false; // Added
  bool _isLoading = false;

  bool get _isValid => _isLengthValid && _isUppercaseValid && _isSpecialValid && _isMatchValid && !_showEmailError && _emailController.text.isNotEmpty; 
  // Should we include email validity in the "Box" validity? 
  // The box says "Mật khẩu hợp lệ/chưa hợp lệ". It focuses on Password. 
  // However, the button checks `_isValid`. 
  // Let's include email check in the button press check, but likely the box remains focused on password.
  // I will update `_isValid` to basically mean "All Form Valid" or keep it password specific and check email separately on submit.
  // For safety, let's keep _isValid as "Password Box State" and add a separate check for button, OR assume button is enabled only if form valid.
  // The prompt says "Đúng thì khung xanh hiện lên", specifically referring to the Password Box. 
  // So `_isValid` should remain focused on Password Validations for the Box UI.
  // But I will add `_isEmailValid` for the general form logic if needed.
  // Let's keep `_isValid` as is (Password Box) and handle email error independently.

  @override
  void initState() {
    super.initState();
    _passController.addListener(_validateAll);
    _confirmPassController.addListener(_validateAll);
    
    // Email Listener
    _emailController.addListener(() {
       final text = _emailController.text;
       if (text.isEmpty) {
         setState(() => _showEmailError = false);
         return;
       }
       bool isGmail = text.endsWith('@gmail.com');
       bool isPhone = text.length == 10 && RegExp(r'^[0-9]+$').hasMatch(text);
       
       setState(() {
         _showEmailError = (!isGmail && !isPhone);
       });
    });
  }

  void _validateAll() {
    final pass = _passController.text;
    final confirm = _confirmPassController.text;

    setState(() {
      // 1. Length Check (8-32)
      _isLengthValid = pass.length >= 8 && pass.length <= 32;
      
      // Show/Hide error text for Password field
      if (pass.isNotEmpty && !_isLengthValid) {
        _showPassLengthError = true;
      } else {
        _showPassLengthError = false;
      }

      // 2. Uppercase Check
      _isUppercaseValid = pass.contains(RegExp(r'[A-Z]'));

      // 3. Special Char Check
      _isSpecialValid = pass.contains(RegExp(r'[!@#\$%^&*(),.?\":{}|&lt;&gt;]'));

      // 4. Match Check
      _isMatchValid = pass.isNotEmpty && pass == confirm;

      if (confirm.isNotEmpty && (confirm.length < 8 || confirm.length > 32)) {
         _showConfirmPassLengthError = true;
      } else {
         _showConfirmPassLengthError = false;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(
          "Đăng kí",
          style: GoogleFonts.poppins(
            color: const Color(0xFF1E3A8A),
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E3A8A)),
             style: IconButton.styleFrom(
                   backgroundColor: const Color(0xFFE3F2FD), 
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
               const SizedBox(height: 10),
               Text(
                 "Nhập thông tin để đăng kí tài khoản",
                 style: GoogleFonts.poppins(color: const Color(0xFFA51C30), fontSize: 13, fontWeight: FontWeight.w600),
                 textAlign: TextAlign.center,
               ),
               const SizedBox(height: 30),
               CustomTextField(
                 hintText: "Nhập email hoặc SĐT",
                 controller: _emailController, // Added controller
               ), 
               if (_showEmailError)
                 Padding(
                   padding: const EdgeInsets.only(left: 10, top: 4),
                   child: Text(
                     "Nhập đúng định dạng gmail (@gmail) và SĐT (10 số)", 
                     style: GoogleFonts.poppins(color: Colors.redAccent, fontSize: 10)
                   ),
                 ),

               const SizedBox(height: 16),
               CustomTextField(
                 hintText: "Nhập mật khẩu", 
                 obscureText: _obscurePass,
                 controller: _passController,
                 suffixIcon: IconButton(
                   onPressed: () => setState(() => _obscurePass = !_obscurePass),
                   icon: Icon(_obscurePass ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
                 ),
               ),
                if (_showPassLengthError)
                 Padding(
                   padding: const EdgeInsets.only(left: 10, top: 4),
                   child: Text("Mật khẩu phải từ 8 - 32 kí tự", style: GoogleFonts.poppins(color: Colors.red, fontSize: 10)),
                 ),

               const SizedBox(height: 16),
               CustomTextField(
                 hintText: "Nhập lại mật khẩu", 
                 obscureText: _obscureConfirmPass,
                 controller: _confirmPassController,
                 suffixIcon: IconButton(
                   onPressed: () => setState(() => _obscureConfirmPass = !_obscureConfirmPass),
                   icon: Icon(_obscureConfirmPass ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
                 ),
               ),
               if (_showConfirmPassLengthError)
                 Padding(
                   padding: const EdgeInsets.only(left: 10, top: 4),
                   child: Text("Mật khẩu phải từ 8 - 32 kí tự", style: GoogleFonts.poppins(color: Colors.red, fontSize: 10)),
                 ),

               const SizedBox(height: 30),

               // Validation Box
               // Logic: "Đúng thì khung xanh", "sai mật khẩu thì hiện màu đỏ sai mật khẩu chưa hợp lệ khung dưới"
               // So if _isValid is true -> Green Box "Mật khẩu hợp lệ"
               // If _isValid is false -> Red Box "Mật khẩu chưa hợp lệ"
               Container(
                 padding: const EdgeInsets.all(12),
                 decoration: BoxDecoration(
                   border: Border.all(color: _isValid ? Colors.green : Colors.red),
                   borderRadius: BorderRadius.circular(12),
                   color: Colors.white,
                 ),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Icon(
                       _isValid ? Icons.check_circle : Icons.cancel, 
                       color: _isValid ? Colors.green : Colors.red,
                       size: 20,
                     ),
                     const SizedBox(width: 10),
                     Expanded(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Text(
                             _isValid ? "Mật khẩu hợp lệ" : "Mật khẩu chưa hợp lệ",
                             style: GoogleFonts.poppins(
                               fontWeight: FontWeight.bold,
                               color: Colors.black, // Text always black per image
                               fontSize: 13
                             ),
                           ),
                           const SizedBox(height: 4),
                           Text("• Từ 8 - 32 kí tự.", style: GoogleFonts.poppins(fontSize: 12, color: _isLengthValid ? Colors.green : Colors.black)),
                           Text("• Có ít nhất 1 kí tự in hoa.", style: GoogleFonts.poppins(fontSize: 12, color: _isUppercaseValid ? Colors.green : Colors.black)), 
                           Text("• Gồm các ký tự đặc biệt (\$, !, @, ...)", style: GoogleFonts.poppins(fontSize: 12, color: _isSpecialValid ? Colors.green : Colors.black)),
                           Text("• Mật khẩu nhập lại phải khớp.", style: GoogleFonts.poppins(fontSize: 12, color: _isMatchValid ? Colors.green : Colors.black)),
                         ],
                       ),
                     )
                   ],
                 ),
               ),
               
               const SizedBox(height: 30),
                _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                 text: 'Tiếp tục',
                 backgroundColor: const Color(0xFF1E3A8A), // Dark Blue
                 onPressed: () async {
                   if (_isValid && !_showEmailError && _emailController.text.isNotEmpty) {
                      setState(() => _isLoading = true);
                      final auth = AuthService();
                      final user = await auth.registerWithEmailAndPassword(
                        _emailController.text.trim(), 
                        _passController.text.trim()
                      );
                      
                      if (!mounted) return;

                      if (user != null) {
                         // Must Sign Out immediately to prevent auto-login by Wrapper
                         await auth.signOut();

                         Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterSuccessScreen()),
                        );
                      } else {
                        setState(() => _isLoading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Đăng ký thất bại. Email có thể đã tồn tại.")),
                        );
                      }
                   }
                 },
               ),
               const SizedBox(height: 20),
               const SizedBox(height: 30),
                Center(
                  child: Text(
                    "Hoặc",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFA51C30), // Red
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
               ),
              const SizedBox(height: 30),
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
                    "Đã có tài khoản? ",
                    style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      "Đăng nhập ngay",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFA51C30), // Red
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

             ],
           ),
        ),
      ),

    );
  }
}

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            // Logo
            const TixioLogo(size: 200),
            const SizedBox(height: 30),
             Text(
              "CHÚC MỪNG BẠN",
              style: GoogleFonts.poppins(color: const Color(0xFF1E3A8A), fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "ĐÃ ĐĂNG KÝ THÀNH CÔNG",
               style: GoogleFonts.poppins(color: const Color(0xFF1E3A8A), fontSize: 14, fontWeight: FontWeight.bold),
               textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
             Text(
              "Hãy tiến hành đăng nhập lại\nvào hệ thống bạn nhé !",
              style: GoogleFonts.poppins(color: const Color(0xFFA51C30), fontSize: 13, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
             CustomButton(
              text: 'Tiếp tục',
              backgroundColor: const Color(0xFF1E3A8A), // Blue color
              width: double.infinity,
              onPressed: () {
                // Navigate back to Login Screen
                 Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
             const Spacer(),
          ],
        ),
      ),

    );
  }
}
