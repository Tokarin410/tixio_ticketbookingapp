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
import 'package:tixio/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added

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
  bool _showEmailError = false; 
  bool _emailExistsError = false; // Added
  bool _isLoading = false;

  bool get _isValid => _isLengthValid && _isUppercaseValid && _isSpecialValid && _isMatchValid && !_showEmailError && _emailController.text.isNotEmpty; 

  @override
  void initState() {
    super.initState();
    _passController.addListener(_validateAll);
    _confirmPassController.addListener(_validateAll);
    
    // Email Listener
    _emailController.addListener(() {
       final text = _emailController.text;
       // Reset Exists Error when typing
       if (_emailExistsError) {
         setState(() => _emailExistsError = false);
       }

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
        leading: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFE3F2FD),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Padding(
                padding: EdgeInsets.only(left: 6.0), // Visually center the iOS arrow
                child: Icon(Icons.arrow_back_ios, color: Color(0xFF1E3A8A), size: 18),
              ),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
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
               if (_emailExistsError) // Added
                 Padding(
                   padding: const EdgeInsets.only(left: 10, top: 4),
                   child: Text(
                     "Email đã tồn tại tài khoản. Vui lòng nhập email khác", 
                     style: GoogleFonts.poppins(color: const Color(0xFFFF8A80), fontSize: 12, fontWeight: FontWeight.bold), // Light red bold
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
                      setState(() => _emailExistsError = false); // Reset error

                      try {
                        final auth = FirebaseAuth.instance;
                        final userCredential = await auth.createUserWithEmailAndPassword(
                          email: _emailController.text.trim(), 
                          password: _passController.text.trim()
                        );
                        final user = userCredential.user;
                        
                        if (!mounted) return;

                        if (user != null) {
                           // Create initial Firestore Profile
                           await FirestoreService().updateUserProfile(user.uid, {
                             'email': _emailController.text.trim(),
                             'fullName': '', // Empty initially
                             'phone': '',
                           });

                           // Must Sign Out immediately to prevent auto-login by Wrapper
                           await auth.signOut();

                           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterSuccessScreen()),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                         setState(() => _isLoading = false);
                         if (e.code == 'email-already-in-use') {
                            setState(() => _emailExistsError = true);
                         } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Đăng ký thất bại: ${e.message}")),
                            );
                         }
                      } catch (e) {
                         setState(() => _isLoading = false);
                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("Lỗi: $e")),
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
                text: 'Đăng kí với Google',
                icon: FontAwesomeIcons.googlePlusG,
                onPressed: () async {
                  setState(() => _isLoading = true);
                  try {
                    final user = await AuthService().signInWithGoogle();
                    
                    if (!mounted) return;
                    if (user != null) {
                      // Success
                      await FirestoreService().updateUserProfile(user.uid, {
                              'email': user.email ?? "",
                              'fullName': user.displayName ?? "",
                              'phone': "",
                      });
                      
                      // Sign out immediately to prevent auto-login
                      await AuthService().signOut();

                      if (!mounted) return;
                      
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterSuccessScreen()),
                      );
                    } else {
                      setState(() => _isLoading = false);
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Đã hủy chọn tài khoản")),
                      );
                    }
                  } catch (e) {
                     setState(() => _isLoading = false);
                     if (!mounted) return;
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text("Lỗi Đăng Ký Google: $e")),
                     );
                  }
                },
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
