import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegulationsScreen extends StatelessWidget {
  const RegulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Quy định',
          style: GoogleFonts.josefinSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
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
             _buildSection(
              title: 'Điều khoản Dịch vụ',
              content:
                  '• Chấp thuận: Việc tạo tài khoản và sử dụng nền tảng Tixio cấu thành sự chấp thuận không hủy ngang đối với toàn bộ Điều khoản Dịch vụ này.\n\n• Tuân thủ Pháp luật: Người dùng cam kết tuân thủ tất cả các luật và quy định hiện hành khi sử dụng dịch vụ.',
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Chính sách Thanh toán & Hoàn tiền',
              content:
                  '• Tất cả các giao dịch mua hàng ảo (Xu, Đăng ký) đều là cuối cùng và không hoàn lại (Non-refundable).\n\n• Ngoại lệ: Hoàn tiền chỉ được xem xét trong trường hợp lỗi kỹ thuật được xác nhận bởi hệ thống Tixio hoặc khi được pháp luật bắt buộc. Không hoàn tiền cho các trường hợp không sử dụng dịch vụ hoặc thay đổi ý định của người dùng.',
            ),
             const SizedBox(height: 16),
            _buildSection(
              title: 'Chính sách Quyền riêng tư',
              content:
                  '• Chia sẻ Dữ liệu: Dữ liệu được sử dụng chủ yếu để vận hành, bảo trì, cải thiện dịch vụ và mục đích pháp lý. Tixio chỉ chia sẻ dữ liệu người dùng với các nhà cung cấp dịch vụ bên thứ ba (ví dụ: cổng thanh toán) theo yêu cầu hoạt động hoặc khi có yêu cầu pháp lý hợp lệ.\n\n• Quyền Truy cập: Người dùng có quyền yêu cầu truy cập, chỉnh sửa hoặc xóa dữ liệu cá nhân của mình, tuân theo các giới hạn pháp lý.',
            ),
          ],
        ),
      ),
    );
  }
   Widget _buildSection({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.josefinSans(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
             textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
