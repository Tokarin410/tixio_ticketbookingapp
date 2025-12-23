import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/buy_ticket/payment_success_screen.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final int remainingTime;
  final String customerName;
  final String ticketSummary;
  final int totalAmount;

  const PaymentProcessingScreen({
    super.key, 
    required this.remainingTime,
    required this.customerName,
    required this.ticketSummary,
    required this.totalAmount,
  });

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.remainingTime;
    startTimer();
  }

  void startTimer() {
    // Override to simulated 4 seconds processing
    _remainingSeconds = 4;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (!mounted) return;
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        
        // Generate current time string e.g. "15:27, 21/12/2025"
        final now = DateTime.now();
        final timeString = "${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}, ${now.day.toString().padLeft(2,'0')}/${now.month.toString().padLeft(2,'0')}/${now.year}";
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccessScreen(
              customerName: widget.customerName,
              ticketClass: widget.ticketSummary,
              totalAmount: widget.totalAmount,
              transactionTime: timeString,
            )
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Thanh toán", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, color: Colors.white)),
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/load + noticket.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Giao dịch đang xử lý....",
                    style: GoogleFonts.josefinSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Bạn vẫn đang trong quá trình thanh toán. Vui lòng đợi trong vài phút và đừng rời khỏi trang để được cập nhật trạng thái thanh toán",
                    style: GoogleFonts.josefinSans(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
