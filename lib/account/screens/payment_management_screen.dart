import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentManagementScreen extends StatefulWidget {
  const PaymentManagementScreen({super.key});

  @override
  State<PaymentManagementScreen> createState() => _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Quản lý thanh toán",
          style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        elevation: 0,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSection(
              "Thẻ tín dụng/Ghi nợ",
              [
                _buildCardItem("MB Bank - NH TMCP Quân đội", "*1234", isVisa: true),
                _buildAddItem("Thêm thẻ tín dụng"),
              ],
            ),
            const SizedBox(height: 24),
             _buildSection(
              "Thẻ Ngân hàng",
              [
                _buildCardItem("MB Bank - NH TMCP Quân đội", "*5678", isBank: true),
                _buildAddItem("Thêm thẻ Ngân hàng"),
              ],
            ),
             const SizedBox(height: 24),
             _buildSection(
              "Ví điện tử",
              [
                _buildCardItem("Momo (mặc định)", "", isMomo: true, hasArrow: true),
                _buildAddItem("Thêm ví điện tử"),
              ],
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity, // Max width as per previous requirements
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF013aad), // Blue button
                   padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Xác nhận", style: GoogleFonts.josefinSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.josefinSans(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Semi-bold for section headers
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0), // Light grey background like mockup
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        )
      ],
    );
  }

  Widget _buildCardItem(String title, String subtitle, {bool isVisa = false, bool isBank = false, bool isMomo = false, bool hasArrow = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 1)), // Divider effect transparent/white
      ),
      child: Row(
        children: [
          // Logo Placeholder
          if (isVisa) 
             Container(
               width: 32, height: 20, 
               decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)), // White bg for visa
               alignment: Alignment.center,
               child: Text("VISA", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: Colors.blue[900])),
             )
          else if (isBank || isMomo)
              Container(
                 width: 24, height: 24,
                 decoration: BoxDecoration(
                   color: isMomo ? Colors.pink : Colors.red, // Mock colors
                   borderRadius: BorderRadius.circular(4)
                 ),
                 child: Icon(isMomo ? Icons.wallet : Icons.account_balance, color: Colors.white, size: 14),
              ),
          
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.josefinSans(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (subtitle.isNotEmpty)
             Text(
               subtitle,
               style: GoogleFonts.josefinSans(fontSize: 14, color: Colors.grey),
             ),
          if (hasArrow)
             const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)
          else if (!isMomo && subtitle.isNotEmpty) // Arrow for card items is just chevron? No, design shows just subtitle often.
             const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildAddItem(String text) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF013aad), // Blue +
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
             const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.josefinSans(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
