import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/homepage/home_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String customerName;
  final String ticketClass; // e.g. "Hạng C x1", "Hạng A x2"
  final int totalAmount;
  final String transactionTime;
  final String eventName;

  const PaymentSuccessScreen({
    super.key,
    required this.customerName,
    required this.ticketClass,
    required this.totalAmount,
    required this.transactionTime,
    required this.eventName,
  });

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                "Thanh toán thành công",
                style: GoogleFonts.josefinSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF013aad),
                ),
              ),
              const SizedBox(height: 20),
              // Illustration 
              Image.asset(
                "assets/images/thanhtoanthanhcong.png",
                height: 200,
                fit: BoxFit.contain,
              ),
              
              const SizedBox(height: 20),
              Text(
                "Thông tin giao dịch",
                style: GoogleFonts.josefinSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              
              // Transaction Details
              _buildDetailRow("Tên sự kiện", eventName, isBoldValue: true),
              _buildDetailRow("Người đặt", customerName, isBoldValue: true),
              _buildDetailRow("Ngày giao dịch", transactionTime, isBoldValue: true),
              _buildDetailRow("Hạng vé", ticketClass, isBoldValue: true),
              _buildDetailRow("Tổng cộng", formatCurrency(totalAmount), isBoldValue: true),
              _buildDetailRow("Tổng cộng", formatCurrency(totalAmount), isBoldValue: true),
              
              // QR Code Placeholder - Just an icon for success visual
              const Icon(
                Icons.check_circle_outline, // Changed to check circle for success feel
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 10),
              Text(
                "Mã vé đã được gửi vào 'Vé của tôi'",
                style: GoogleFonts.josefinSans(color: Colors.grey),
              ),
              
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                     // Navigate back to Home and clear stack
                     Navigator.of(context).pushAndRemoveUntil(
                       MaterialPageRoute(builder: (context) => const HomeScreen()),
                       (route) => false,
                     );
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF013aad),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text("Xác nhận", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBoldValue = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Handle multiline
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label, 
              style: GoogleFonts.josefinSans(color: Colors.grey, fontSize: 14)
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value, 
              textAlign: TextAlign.right,
              style: GoogleFonts.josefinSans(
                fontWeight: isBoldValue ? FontWeight.bold : FontWeight.normal, 
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
