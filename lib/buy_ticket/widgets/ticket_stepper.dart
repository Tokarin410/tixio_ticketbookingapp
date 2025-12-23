import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketStepper extends StatelessWidget {
  final int currentStep; // 1, 2, or 3

  const TicketStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepItem(1, "Chọn vé", CrossAxisAlignment.center),
            Expanded(child: _buildLine(1)),
            _buildStepItem(2, "Thông tin thanh toán", CrossAxisAlignment.center),
            Expanded(child: _buildLine(2)),
            _buildStepItem(3, "Xác nhận", CrossAxisAlignment.center),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(int step, String label, CrossAxisAlignment align) {
    bool isActive = step <= currentStep;
    
    return SizedBox(
      width: 32, // Constrain width to circle size
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF013aad) : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              step.toString(),
              style: GoogleFonts.josefinSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 30, // Constrain height to avoid infinity error
            child: OverflowBox(
              maxWidth: 120, 
              maxHeight: 40,
              alignment: Alignment.topCenter,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.black : Colors.grey,
                ),
                maxLines: 1, 
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine(int stepAfter) {
    return Container(
      height: 2,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.only(top: 15), // Align with circle center (16) - half line height (1) = 15
    );
  }
}
