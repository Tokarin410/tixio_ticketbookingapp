import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/buy_ticket/payment_processing_screen.dart';
import 'package:tixio/buy_ticket/widgets/payment_method_popup.dart';
import 'package:tixio/buy_ticket/widgets/ticket_stepper.dart';

import 'package:tixio/models/event_model.dart';

class ConfirmationScreen extends StatefulWidget {
  final int totalAmount;
  final int remainingTime;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String ticketSummary;
  final Event event;
  final int initialPaymentMethod; 
  
  const ConfirmationScreen({
    super.key, 
    required this.totalAmount,
    required this.remainingTime,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.ticketSummary,
    required this.event,
    required this.initialPaymentMethod,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  Timer? _timer;
  late int _remainingSeconds;
  late int _selectedPaymentMethod; 
  
  final List<Map<String, dynamic>> _methods = [
    {"label": "Thẻ tín dụng", "icon": Icons.credit_card, "color": Colors.blue},
    {"label": "Thẻ ngân hàng", "icon": Icons.account_balance, "color": Colors.red},
    {"label": "Ví điện tử Momo", "icon": Icons.wallet, "color": Colors.pink},
  ];
  
  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.remainingTime; // Init with passed time
    _selectedPaymentMethod = widget.initialPaymentMethod; // Init with passed method
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (!mounted) return; // Safety check
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        // Handle timeout
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
                         // Pop back to Choose Ticket Screen
                         // Close dialog
                         Navigator.of(dialogContext).pop(); 
                         
                         // Stack: ChooseTicket -> PaymentInfo -> Confirmation
                         // We need to pop Confirmation AND PaymentInfo to get back to ChooseTicket.
                         int count = 0;
                         Navigator.of(context).popUntil((route) {
                            return count++ == 2;
                         });
                         // Or safer manual approach if popUntil is tricky without named routes:
                         Navigator.of(context).pop(); // Confirmation
                         Navigator.of(context).pop(); // PaymentInfo
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
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text("Xác nhận", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, color: Colors.white)),
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
               style: GoogleFonts.josefinSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
             ),
           ),
           
           Expanded(
             child: SingleChildScrollView(
               padding: const EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   // Stepper
                   const TicketStepper(currentStep: 3),
                   const SizedBox(height: 20),
                   
                   // TICKET CARD
                   Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       boxShadow: [
                         BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                       ]
                     ),
                     child: Column(
                       children: [
                         // Banner
                         ClipRRect(
                           borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                           child: Image.asset(
                             widget.event.posterImage, 
                             height: 180,
                             width: double.infinity,
                             fit: BoxFit.cover,
                             errorBuilder: (c, e, s) => Container(height: 180, color: Colors.grey.shade300, child: const Center(child: Icon(Icons.image, size: 50))),
                           ),
                         ),
                         
                         Padding(
                           padding: const EdgeInsets.all(16),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 widget.event.title.toUpperCase(),
                                 style: GoogleFonts.josefinSans(fontSize: 24, fontWeight: FontWeight.w900, height: 1.1),
                               ),
                               const SizedBox(height: 12),
                               Row(
                                 children: [
                                   const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                   const SizedBox(width: 6),
                                   Expanded(child: Text(widget.event.location, style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.w600))),
                                 ],
                               ),
                               const SizedBox(height: 6),
                               Row(
                                 children: [
                                   const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                                   const SizedBox(width: 6),
                                   Text(widget.event.dateTime, style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.w600)),
                                 ],
                               ),
                               
                               const SizedBox(height: 16),
                               Text("Thông tin vé", style: GoogleFonts.josefinSans(fontSize: 17, color: Colors.grey.shade600)),
                               const SizedBox(height: 4),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text("Hạng vé", style: GoogleFonts.josefinSans(fontSize: 12, color: Colors.grey.shade400)),
                                       // Allow text to wrap or ellipsize
                                       Container(
                                         constraints: const BoxConstraints(maxWidth: 160),
                                         child: Text(widget.ticketSummary, style: GoogleFonts.josefinSans(fontSize: 19, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                                       ),
                                     ],
                                   ),
                                   /*
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text("Số lượng", style: GoogleFonts.josefinSans(fontSize: 12, color: Colors.grey.shade400)),
                                       Text("01", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold)),
                                     ],
                                   ),
                                   */
                                   const SizedBox(width: 40), // spacer
                                 ],
                               )
                             ],
                           ),
                         ),
                         
                         // Separator
                         const TicketSeparatorEx(),
                         
                         // Booking Info
                         Padding(
                           padding: const EdgeInsets.all(16),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Thông tin đặt vé", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold)),
                               const SizedBox(height: 10),
                               _buildInfoRow("Họ và tên", widget.customerName),
                               _buildInfoRow("Email", widget.customerEmail),
                               _buildInfoRow("SĐT", widget.customerPhone),
                               const SizedBox(height: 10),
                               Text("Phương thức thanh toán", style: GoogleFonts.josefinSans(fontSize: 16, color: Colors.grey)),
                               const SizedBox(height: 8),
                               Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey.shade200),
                                    color: Colors.grey.shade50
                                  ),
                                  child: Row(
                                    children: [
                                       Container(
                                         width: 24, height: 24, 
                                         margin: const EdgeInsets.only(right: 8),
                                         decoration: BoxDecoration(
                                           color: _methods[_selectedPaymentMethod]['icon'] == Icons.wallet ? Colors.pink : Colors.transparent, 
                                           borderRadius: BorderRadius.circular(4)
                                         ),
                                         child: Icon(
                                           _methods[_selectedPaymentMethod]['icon'], 
                                           color: _methods[_selectedPaymentMethod]['icon'] == Icons.wallet ? Colors.white : _methods[_selectedPaymentMethod]['color'], 
                                           size: _methods[_selectedPaymentMethod]['icon'] == Icons.wallet ? 16 : 24
                                         ),
                                       ),
                                       Expanded(child: Text(_methods[_selectedPaymentMethod]['label'], style: GoogleFonts.josefinSans(fontWeight: FontWeight.w600))),
                                       GestureDetector(
                                         onTap: () async {
                                           final result = await showModalBottomSheet(
                                             context: context,
                                             isScrollControlled: true, 
                                             backgroundColor: Colors.transparent,
                                             builder: (context) => PaymentMethodPopup(selectedIndex: _selectedPaymentMethod),
                                           );
                                           
                                           if (result != null && result is int) {
                                             setState(() {
                                               _selectedPaymentMethod = result;
                                             });
                                           }
                                         },
                                         child: Text("Thay đổi", style: GoogleFonts.josefinSans(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                                       ),
                                    ],
                                  ),
                                )
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                   
                   const SizedBox(height: 100),
                 ],
               ),
             ),
           ),
           
           // Bottom Bar
           Container(
             padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
             decoration: BoxDecoration(
               color: Colors.white,
               boxShadow: [
                 BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
               ]
             ),
             child: SafeArea(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Tổng cộng", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold)),
                       Text(formatCurrency(widget.totalAmount), style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFFb11d39))),
                     ],
                   ),
                   const SizedBox(height: 16),
                   SizedBox(
                     width: double.infinity,
                     height: 50,
                     child: ElevatedButton(
                       onPressed: () {
                          // Show Processing Dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: Colors.black54,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: const Color(0xFF2B2B2B), // Dark background
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 180, height: 180,
                                        alignment: Alignment.center,
                                        child: Image.asset("assets/images/load + noticket.png", fit: BoxFit.contain),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Hệ thống đang xử lý ...",
                                        style: GoogleFonts.josefinSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                          
                          // Mock Delay and Navigation
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pop(context); // Close Dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentProcessingScreen(
                                  remainingTime: _remainingSeconds,
                                  customerName: widget.customerName,
                                  ticketSummary: widget.ticketSummary,
                                  totalAmount: widget.totalAmount,
                                  event: widget.event,
                                ),
                              ),
                            );
                          });
                       }, 
                       style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xFF013aad),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       ),
                       child: Text("Thanh toán", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.josefinSans(color: Colors.grey, fontSize: 16)),
          Text(value, style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 17)),
        ],
      ),
    );
  }
}

// Replicated Separator
class TicketSeparatorEx extends StatelessWidget {
  const TicketSeparatorEx({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: Stack(
        children: [
          Center(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0),
               child: CustomPaint(
                size: const Size(double.infinity, 1),
                painter: DashedLineHorizontalPainterEx(),
               ),
             ),
          ),
          Positioned(
            left: -15, 
            top: 0, bottom: 0,
            child: Container(width: 30, height: 30, decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle)), // Match bg color grey.shade50
          ),
          Positioned(
            right: -15,
            top: 0, bottom: 0,
            child: Container(width: 30, height: 30, decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle)),
          ),
        ],
      ),
    );
  }
}

class DashedLineHorizontalPainterEx extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 8, dashSpace = 6, startX = 0;
    final paint = Paint()..color = Colors.grey.shade300..strokeWidth = 1.5;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
