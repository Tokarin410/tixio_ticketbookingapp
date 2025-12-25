import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketDetailScreen extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String quantity;
  final String ticketClass;
  final String ticketId; 
  final String imagePath; // Added imagePath

  const TicketDetailScreen({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.quantity,
    required this.ticketClass,
    required this.ticketId, 
    required this.imagePath, // Added imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Thông tin vé",
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24, 
          ),
        ),
        centerTitle: true,

        backgroundColor: const Color(0xFF013aad),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    imagePath, // Use dynamic imagePath
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                      );
                    },
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Title
                      Text(
                        title.toUpperCase(),
                        style: GoogleFonts.josefinSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Location
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              location,
                              style: GoogleFonts.josefinSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Date
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, color: Colors.grey, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            date,
                            style: GoogleFonts.josefinSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      Text(
                        "Thông tin vé",
                        style: GoogleFonts.josefinSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Ticket Info Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailItem("Hạng vé", ticketClass),
                          _buildDetailItem("Số lượng", quantity),
                          const SizedBox(width: 40), 
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Separator with Notches
                const TicketSeparator(),
                
                // QR Code Section
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180,
                          width: 180,
                          child: QrImageView(
                            data: ticketId, // Unique Ticket ID
                            version: QrVersions.auto,
                            size: 180.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Mã vé: ${ticketId.substring(0, 8).toUpperCase()}",
                          style: GoogleFonts.josefinSans(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: GoogleFonts.josefinSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class TicketSeparator extends StatelessWidget {
  const TicketSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        children: [
          // Dashed Line
          Center(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0), // Indent dashed line slightly
               child: CustomPaint(
                size: const Size(double.infinity, 1),
                painter: DashedLineHorizontalPainter(),
               ),
             ),
          ),
          // Left Notch
          Positioned(
            left: -15, // Negative position to create a semi-circle cutout effect
            top: 0,
            bottom: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.white, // Match Scaffold background. 
                // Note: Since background is white and card is white, this won't show 'cutout' unless card has shadow. 
                // If shadow is outside, this just covers the shadow.
                // For a proper cutout effect with shadow, a generic clipper is needed.
                // But simplified: A grey circle might simulate a 'hole' seeing the grey background? 
                // Scaffold bg is White. So a white circle is correct. It creates a 'void' in the card boundary.
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Right Notch
          Positioned(
            right: -15,
            top: 0,
            bottom: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLineHorizontalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 8, dashSpace = 6, startX = 0;
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.5;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
