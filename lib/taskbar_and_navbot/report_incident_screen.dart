import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportIncidentScreen extends StatelessWidget {
  const ReportIncidentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Báo cáo sự cố & hỗ trợ',
          style: GoogleFonts.josefinSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22, // Adjusted font size slightly
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
               decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                // No border for the container itself, ensuring clean look
              ),
              child: Text(
                '• Biểu mẫu này được thiết lập để thu thập thông tin chi tiết về các sự cố liên quan đến vi phạm Tiêu chuẩn Cộng đồng, an ninh tài khoản, hoặc lỗi vận hành.\n\n• Để đảm bảo hiệu quả xử lý, người báo cáo phải cung cấp đầy đủ:\n    • (i) Loại sự cố: (Ví dụ: Vi phạm ToS, Lừa đảo, Lỗi hệ thống);\n    • (ii) Thông tin Định danh: ID hoặc tên người dùng của đối tượng bị báo cáo;\n    • (iii) Mô tả Sự việc: Cung cấp chi tiết cụ thể về hành vi vi phạm, thời gian và địa điểm xảy ra;\n\nĐội ngũ Tixio sẽ tiến hành điều tra, bảo mật thông tin người báo cáo, và thực hiện các biện pháp cần thiết. Cảm ơn bạn!',
                style: GoogleFonts.josefinSans(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withAlpha(100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Hãy cho Tixio biết bạn muốn hỗ trợ gì nhé!',
                  hintStyle: GoogleFonts.josefinSans(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.josefinSans(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
