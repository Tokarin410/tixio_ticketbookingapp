import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodPopup extends StatefulWidget {
  final int selectedIndex;
  const PaymentMethodPopup({super.key, required this.selectedIndex});

  @override
  State<PaymentMethodPopup> createState() => _PaymentMethodPopupState();
}

class _PaymentMethodPopupState extends State<PaymentMethodPopup> {
  late int _selectedIndex;

  final List<Map<String, dynamic>> _methods = [
    {"label": "Thẻ tín dụng", "icon": Icons.credit_card, "color": Colors.blue, "prefix": "VISA"},
    {"label": "Thẻ ngân hàng", "icon": Icons.account_balance, "color": Colors.red, "prefix": ""},
    {"label": "Ví điện tử Momo", "icon": Icons.wallet, "color": Colors.pink, "prefix": ""},
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

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
                const SizedBox(width: 24),
                Text(
                  "Phương thức thanh toán",
                  style: GoogleFonts.josefinSans(
                    fontSize: 18,
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
               children: [
                 // Options
                 ListView.separated(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: _methods.length,
                   separatorBuilder: (context, index) => const SizedBox(height: 12),
                   itemBuilder: (context, index) {
                     final method = _methods[index];
                     bool isSelected = _selectedIndex == index;
                     return GestureDetector(
                       onTap: () => setState(() => _selectedIndex = index),
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
                             const SizedBox(width: 12),
                             if (method['prefix'].toString().isNotEmpty) ...[
                               Text(method['prefix'], style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, color: const Color(0xFF013aad))), // VISA style
                               const SizedBox(width: 4),
                             ] else
                               Container(
                                 padding: const EdgeInsets.all(2),
                                 margin: const EdgeInsets.only(right: 8),
                                 decoration: BoxDecoration(color: method['icon'] == Icons.wallet ? Colors.pink : Colors.transparent, borderRadius: BorderRadius.circular(4)),
                                 child: Icon(method['icon'], color: method['icon'] == Icons.wallet ? Colors.white : method['color'], size: method['icon'] == Icons.wallet ? 14 : 20),
                               ),
                             
                             Text(
                               method['label'],
                               style: GoogleFonts.josefinSans(
                                 fontSize: 16,
                                 fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                 color: Colors.black87
                               ),
                             ),
                           ],
                         ),
                       ),
                     );
                   },
                 ),
                 
                 const SizedBox(height: 24),
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
                           onPressed: () => Navigator.pop(context, _selectedIndex),
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
