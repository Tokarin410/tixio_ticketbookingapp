import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionPopup extends StatefulWidget {
  const PromotionPopup({super.key});

  @override
  State<PromotionPopup> createState() => _PromotionPopupState();
}

class _PromotionPopupState extends State<PromotionPopup> {
  int? _selectedVoucherIndex = 0; // Default first option selected

  final List<Map<String, dynamic>> _vouchers = [
    {"label": "Giảm 20.000đ", "value": 20000},
    {"label": "Giảm 5.000đ", "value": 5000},
    {"label": "Giảm 2.000đ", "value": 2000},
    {"label": "Giảm 10.000đ", "value": 10000},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24), // Spacer for centering
                Text(
                  "Mã khuyến mãi",
                  style: GoogleFonts.josefinSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 24, color: Colors.black),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          
          Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // Input Row
                 Row(
                   children: [
                     Expanded(
                       child: Container(
                         height: 45,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey.shade400),
                           borderRadius: BorderRadius.circular(8),
                         ),
                         padding: const EdgeInsets.symmetric(horizontal: 12),
                         alignment: Alignment.centerLeft,
                         child: TextField(
                           decoration: InputDecoration(
                             hintText: "Nhập mã voucher",
                             hintStyle: GoogleFonts.josefinSans(color: Colors.grey),
                             border: InputBorder.none,
                             isDense: true,
                             contentPadding: EdgeInsets.zero,
                           ),
                           style: GoogleFonts.josefinSans(),
                         ),
                       ),
                     ),
                     const SizedBox(width: 12),
                     ElevatedButton(
                       onPressed: () {},
                       style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xFF013aad),
                         foregroundColor: Colors.white,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                         minimumSize: const Size(0, 45),
                       ),
                       child: Text("Áp dụng", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
                     )
                   ],
                 ),
                 
                 const SizedBox(height: 20),
                 Text("Voucher từ Tixio", style: GoogleFonts.josefinSans(fontSize: 16, color: Colors.grey.shade700)),
                 const SizedBox(height: 10),
                 
                 // List of Vouchers
                 SizedBox(
                   height: 200, // Limit height for list
                   child: ListView.separated(
                     itemCount: _vouchers.length,
                     separatorBuilder: (context, index) => const SizedBox(height: 10),
                     itemBuilder: (context, index) {
                       final voucher = _vouchers[index];
                       bool isSelected = _selectedVoucherIndex == index;
                       return GestureDetector(
                         onTap: () => setState(() => _selectedVoucherIndex = index),
                         child: Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                           decoration: BoxDecoration(
                             border: Border.all(color: isSelected ? const Color(0xFF013aad) : Colors.grey.shade300),
                             borderRadius: BorderRadius.circular(4),
                           ),
                           child: Row(
                             children: [
                               Icon(
                                 isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                 color: isSelected ? const Color(0xFF013aad) : Colors.grey,
                                 size: 20,
                               ),
                               const SizedBox(width: 10),
                               Text(
                                 voucher['label'],
                                 style: GoogleFonts.josefinSans(
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.black87
                                 ),
                               ),
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 ),
                 
                 const SizedBox(height: 20),
                 // Bottom Buttons
                 SafeArea(
                   child: Row(
                     children: [
                       Expanded(
                         child: OutlinedButton(
                           onPressed: () => Navigator.pop(context),
                           style: OutlinedButton.styleFrom(
                             side: const BorderSide(color: Color(0xFF013aad)),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                             padding: const EdgeInsets.symmetric(vertical: 12),
                           ),
                           child: Text("Huỷ bỏ", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
                         ),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: ElevatedButton(
                           onPressed: () => Navigator.pop(context, _selectedVoucherIndex != null ? _vouchers[_selectedVoucherIndex!]['value'] : 0),
                           style: ElevatedButton.styleFrom(
                             backgroundColor: const Color(0xFF013aad),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                             padding: const EdgeInsets.symmetric(vertical: 12),
                           ),
                           child: Text("Xong", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                         ),
                       ),
                     ],
                   ),
                 )
               ],
             ),
          ),
        ],
      ),
    );
  }
}
