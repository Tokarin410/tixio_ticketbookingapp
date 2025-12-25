import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/buy_ticket/confirmation_screen.dart';
import 'package:tixio/buy_ticket/widgets/promotion_popup.dart';
import 'package:tixio/buy_ticket/widgets/ticket_stepper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tixio/models/event_model.dart';

class PaymentInfoScreen extends StatefulWidget {
  final String amount; 
  final String ticketInfo;
  final Event event; 

  const PaymentInfoScreen({
    super.key, 
    required this.amount, 
    this.ticketInfo = "",
    required this.event, 
  });

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  // Timer Logic
  Timer? _timer;
  int _remainingSeconds = 900; // 15 minutes
  
  // Form Logic
  final _formKey = GlobalKey<FormState>(); 
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  int _selectedPaymentMethod = 2; // Default Momo
  int _discountAmount = 0; 
  
  // Parse amount string back to int for calculation if needed, or just use string
  int get numericTotal {
     // "2.000.000đ" -> 2000000
     String clean = widget.amount.replaceAll('.', '').replaceAll('đ', '').trim();
     return int.tryParse(clean) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    _loadDefaultPaymentMethod();
  }

  Future<void> _loadDefaultPaymentMethod() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedPaymentMethod = prefs.getInt('default_payment_method') ?? 2;
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (!mounted) return;
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _showTimeoutDialog();
      }
    });
  }

  void _showTimeoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(child: Text("Hết thời gian giữ vé !", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold))),
          content: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Text(
                 "Đã hết thời gian giữ vé. Vui lòng đặt lại vé mới",
                 textAlign: TextAlign.center,
                 style: GoogleFonts.josefinSans(fontSize: 14, color: Colors.grey),
               ),
               const SizedBox(height: 20),
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: () {
                     Navigator.of(dialogContext).pop(); 
                     Navigator.of(context).pop(); 
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xFF013aad),
                     padding: const EdgeInsets.symmetric(vertical: 12),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                   ),
                   child: Text("Đặt vé mới", style: GoogleFonts.josefinSans(color: Colors.white, fontWeight: FontWeight.bold)),
                 ),
               )
             ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  String get timerString {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String formatCurrency(int amount) {
    String str = amount.toString();
    if (amount == 0) return "0đ";
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
       if (i > 0 && (str.length - i) % 3 == 0) {
         buffer.write('.');
       }
       buffer.write(str[i]);
    }
    return "${buffer.toString()}đ";
  }
  
  // Calculate final total based on numeric total and discount
  int get finalTotalNumeric => numericTotal - _discountAmount > 0 ? numericTotal - _discountAmount : 0;

  List<String> get dateParts {
    try {
      // Expecting "dd/MM/yyyy" e.g. "27/12/2025"
      final parts = widget.event.dateOnly.split('/');
      if (parts.length >= 2) {
        return [parts[0], parts[1]]; // [Day, Month]
      }
    } catch (e) {
      // ignore
    }
    return ["??", "??"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text("Thông tin thanh toán", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
           // Countdown Bar
           Container(
             width: double.infinity,
             padding: const EdgeInsets.symmetric(vertical: 8),
             color: Colors.red,
             alignment: Alignment.center,
             child: Text(
               "Hoàn tất đặt vé trong $timerString",
               style: GoogleFonts.josefinSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
             ),
           ),
           
           Expanded(
             child: SingleChildScrollView(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   // Steps
                   const TicketStepper(currentStep: 2),
                   const SizedBox(height: 20),
                   const SizedBox(height: 20),

                   // Event Info Brief
                   Container(
                     padding: const EdgeInsets.all(12),
                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                     child: Row(
                       children: [
                         Container(
                           width: 50, height: 50,
                           decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(8)),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("Tháng ${dateParts[1]}", style: GoogleFonts.josefinSans(fontSize: 8, color: Colors.grey)),
                               Text(dateParts[0], style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold)),
                             ],
                           ),
                         ),
                         const SizedBox(width: 12),
                         Expanded(
                               child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(widget.event.title.toUpperCase(), style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 15)),
                                 // Show summary of tickets if available if passed
                                 Text("Tổng tiền: ${widget.amount}", style: GoogleFonts.josefinSans(fontSize: 14, color: Colors.black)),
                               ],
                             ),
                           )
                         ],
                       ),
                     ),
                     
                     const SizedBox(height: 20),
                     
                     // Form Section
                     Container(
                       padding: const EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: Colors.blue, width: 1.5) // Blue border as per design focus
                       ),
                       child: Form( // Wrapped in Form
                         key: _formKey,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text("Thông tin đặt vé", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
                                 GestureDetector(
                                   onTap: () => Navigator.pop(context),
                                   child: Text("Chọn lại vé", style: GoogleFonts.josefinSans(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFFb11d39))),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 16),
                             _buildTextField("Họ và tên *", _nameController, validator: (val) {
                               if (val == null || val.isEmpty) return "Vui lòng nhập họ và tên";
                               return null;
                             }),
                             const SizedBox(height: 12),
                             _buildTextField("Email *", _emailController, validator: (val) {
                               if (val == null || val.isEmpty) return "Vui lòng nhập email";
                               if (!val.contains('@')) return "Email không hợp lệ";
                               return null;
                             }),
                             const SizedBox(height: 12),
                             _buildTextField("SĐT *", _phoneController, validator: (val) {
                                if (val == null || val.isEmpty) return "Vui lòng nhập số điện thoại";
                                if (!RegExp(r'^[0-9]+$').hasMatch(val)) return "Số điện thoại chỉ được chứa số";
                                return null;
                             }),
                             const SizedBox(height: 8),
                             Text("Vui lòng trả lời tất cả các câu hỏi để tiếp tục", style: GoogleFonts.josefinSans(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic))
                           ],
                         ),
                       ),
                     ),
 
                     const SizedBox(height: 20),
                     // Payment Methods
                     Container(
                       padding: const EdgeInsets.all(16),
                       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Phương thức thanh toán", style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
                           const SizedBox(height: 10),
                           _buildRadioOption(0, "Visa Thẻ tín dụng", Icons.credit_card),
                           _buildRadioOption(1, "Thẻ ngân hàng", Icons.account_balance),
                           _buildRadioOption(2, "Ví điện tử Momo", Icons.account_balance_wallet, isMomo: true),
                         ],
                       ),
                     ),
 
                     const SizedBox(height: 20),
                     // Promotion
                     GestureDetector(
                       onTap: () async {
                         final result = await showModalBottomSheet(
                           context: context,
                           isScrollControlled: true,
                           backgroundColor: Colors.transparent,
                           builder: (context) => const PromotionPopup(),
                         );
                         
                         if (result != null && result is int) {
                           setState(() {
                             _discountAmount = result;
                           });
                         }
                       },
                       child: Container(
                         padding: const EdgeInsets.all(16),
                         decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mã khuyến mãi", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
                                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  if (_discountAmount > 0) ...[
                                     Container(
                                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                       decoration: BoxDecoration(
                                         border: Border.all(color: Colors.grey.shade400),
                                         borderRadius: BorderRadius.circular(20),
                                       ),
                                       child: Text(
                                        "Giảm ${formatCurrency(_discountAmount)}",
                                        style: GoogleFonts.josefinSans(color: Colors.black, fontWeight: FontWeight.bold)
                                       ),
                                     ),
                                     const SizedBox(width: 10),
                                  ],
                                  
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.add, size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Thêm khuyến mãi", 
                                          style: GoogleFonts.josefinSans(color: Colors.grey, fontWeight: FontWeight.bold)
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                           ],
                         ),
                       ),
                     ),
                     const SizedBox(height: 100),
                   ],
                 ),
               ),
             ),
 
             // Bottom Bar
              Container(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
               decoration: BoxDecoration(
                 color: Colors.white,
                 boxShadow: [
                   BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
                 ]
               ),
               child: SafeArea( // Wrap in SafeArea
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Tổng cộng", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold)),
                         Text(formatCurrency(finalTotalNumeric), style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFFb11d39))),
                       ],
                     ),
                     const SizedBox(height: 16),
                     SizedBox(
                       width: double.infinity,
                       height: 50,
                       child: ElevatedButton(
                         onPressed: () {
                            // Validate Form
                            if (_formKey.currentState!.validate()) {
                              // Navigate to Confirmation Screen only if valid
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmationScreen(
                                    totalAmount: finalTotalNumeric,
                                    remainingTime: 900, // 15 minutes
                                    customerName: _nameController.text.isEmpty ? "Khách hàng" : _nameController.text,
                                    customerEmail: _emailController.text, // Added email
                                    customerPhone: _phoneController.text, // Added phone
                                    ticketSummary: widget.ticketInfo,
                                    event: widget.event, // Pass event
                                    initialPaymentMethod: _selectedPaymentMethod, // Pass selected method
                                  ), 
                                )
                              );

                          } else {
                            // Show potential error message or just let validators show under fields
                            ScaffoldMessenger.of(context).showSnackBar( // Optional feedback
                               const SnackBar(content: Text("Vui lòng điền đầy đủ thông tin đặt vé"), duration: Duration(seconds: 1))
                            );
                          }
                       }, 
                       style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xFF013aad),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       ),
                       child: Text("Tiếp tục", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                     ),
                   )
                 ],
               ),
             ),
           )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 6),
        TextFormField( // Changed to TextFormField
          controller: controller,
          validator: validator, // Added validator
          autovalidateMode: AutovalidateMode.onUserInteraction, // Show error when typing
          decoration: InputDecoration(
             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF013aad), width: 1.5)),
             errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
             focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red, width: 1.5)),
          ),
        )
      ],
    );
  }

  Widget _buildRadioOption(int value, String label, IconData icon, {bool isMomo = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
           if (isMomo) 
             Container(
               width: 24, height: 24, 
               margin: const EdgeInsets.only(right: 8),
               decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(4)),
               child: const Icon(Icons.wallet, color: Colors.white, size: 16), // Placeholder for Momo logo
             )
           else
             Icon(icon, color: value == 0 ? Colors.blue : Colors.red, size: 24),
           
           const SizedBox(width: 8),
           Text(label, style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
      leading: Radio(
        value: value, 
        groupValue: _selectedPaymentMethod, 
        onChanged: (val) {
          setState(() {
            _selectedPaymentMethod = val as int;
          });
        },
        activeColor: const Color(0xFF013aad),
      ),
    );
  }
}
