import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/account/widgets/success_dialog.dart';
import 'package:tixio/widgets/zigzag_clipper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: "Phan Khánh Nam");
  final _dobController = TextEditingController(text: "04/10/2005");
  final _emailController = TextEditingController(text: "alphahahaha@gmail.com");
  final _phoneController = TextEditingController(text: "(+84) 0123456789");
  
  String _gender = "Nam"; // Initial value set here for now, better to set in initState if tracking changes

  // Store initial values for comparison
  late String _initialName;
  late String _initialDob;
  late String _initialEmail;
  late String _initialPhone;
  late String _initialGender;

  @override
  void initState() {
    super.initState();
    _initialName = _nameController.text;
    _initialDob = _dobController.text;
    _initialEmail = _emailController.text;
    _initialPhone = _phoneController.text;
    _initialGender = _gender;
  }

  bool _hasChanges() {
    return _nameController.text != _initialName ||
        _dobController.text != _initialDob ||
        _emailController.text != _initialEmail ||
        _phoneController.text != _initialPhone ||
        _gender != _initialGender;
  }

  void _handleBackNavigation() {
    if (_hasChanges()) {
      _showUnsavedChangesDialog();
    } else {
      Navigator.pop(context);
    }
  }

  void _showUnsavedChangesDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nếu rời đi thông tin bạn vừa đổi sẽ không được lưu?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.josefinSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog, stay on screen
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF013aad)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          "Ở lại",
                          style: GoogleFonts.josefinSans(
                            color: const Color(0xFF013aad),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(context).pop(); // Navigate back from screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF013aad),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                           padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          "Tiếp tục",
                          style: GoogleFonts.josefinSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildTextField(String label, TextEditingController controller, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          style: GoogleFonts.josefinSans(fontSize: 16),
          decoration: InputDecoration(
            filled: !enabled,
            fillColor: !enabled ? Colors.grey.shade300 : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18), // Widened
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Radius 15
              borderSide: const BorderSide(color: Colors.grey),
            ),
             enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Radius 15
              borderSide: const BorderSide(color: Colors.grey),
            ),
             disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Radius 15
              borderSide: BorderSide.none, // No border for disabled per design appearance
            ),
            suffixIcon: enabled 
              ? const Icon(Icons.edit, color: Colors.grey, size: 20)
              : null, // No edit icon if disabled
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Thông tin tài khoản",
          style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        elevation: 0,
        leading: Center(
          child: InkWell(
            onTap: _handleBackNavigation,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                   Container(
                    width: 80, 
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2), // Keep white border or remove? Image has it? Hard to see, keep for safety or remove if plain.
                      // Actually image has shadow? Or just cutout. Let's keep it simple.
                      image: const DecorationImage(
                        image: AssetImage("assets/images/ava_user.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Thay đổi ảnh đại diện",
                    style: GoogleFonts.josefinSans(
                      color: const Color(0xFFb11d39), // Red color
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 50),
            
            Text(
              "CHỈNH SỬA THÔNG TIN",
              style: GoogleFonts.josefinSans(
                color: const Color(0xFF013aad),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("Họ và tên", _nameController),
                  const SizedBox(height: 16),
                  _buildTextField("Ngày tháng năm sinh", _dobController),
                  const SizedBox(height: 16),
                  _buildTextField("Email nhận vé", _emailController),
                  const SizedBox(height: 16),
                  _buildTextField("Số điện thoại", _phoneController, enabled: false),
                  const SizedBox(height: 16),
                  
                  // Gender
                  Text("Giới tính", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 14)),
                  Row(
                    children: [
                      Radio(value: "Nam", groupValue: _gender, onChanged: (v) => setState(() => _gender=v.toString()), activeColor: const Color(0xFF013aad)),
                      Text("Nam", style: GoogleFonts.josefinSans()),
                      const SizedBox(width: 20),
                      Radio(value: "Nữ", groupValue: _gender, onChanged: (v) => setState(() => _gender=v.toString()), activeColor: const Color(0xFF013aad)),
                       Text("Nữ", style: GoogleFonts.josefinSans()),
                       const SizedBox(width: 20),
                      Radio(value: "Khác", groupValue: _gender, onChanged: (v) => setState(() => _gender=v.toString()), activeColor: const Color(0xFF013aad)),
                       Text("Khác", style: GoogleFonts.josefinSans()),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _handleBackNavigation,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            "Quay về", 
                            style: GoogleFonts.josefinSans(
                              color: Colors.black, 
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                             showDialog(
                               context: context,
                               barrierDismissible: false,
                               builder: (dialogContext) {
                                 Future.delayed(const Duration(milliseconds: 1000), () {
                                   if (dialogContext.mounted) {
                                     Navigator.of(dialogContext).pop(); // Close Dialog using its own context
                                     if (context.mounted) {
                                        Navigator.of(context).pop(); // Close Screen using original context
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
                            backgroundColor: const Color(0xFFb11d39), // Red button
                             padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text("Hoàn thành", style: GoogleFonts.josefinSans(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
