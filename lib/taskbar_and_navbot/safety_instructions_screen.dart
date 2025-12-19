import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SafetyInstructionsScreen extends StatelessWidget {
  const SafetyInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Hướng dẫn an toàn', // Updated title
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
              title: 'Tiêu chuẩn Ứng xử Cộng đồng',
              content:
                  'Mọi người dùng, bao gồm cả Người tạo sự kiện (BTC) và Người mua (Fan), phải cam kết tương tác trên cơ sở tôn trọng lẫn nhau. Nghiêm cấm mọi hành vi Quấy rối, Bắt nạt, Đe dọa hoặc sử dụng Ngôn ngữ Kích động Thù địch dựa trên chủng tộc, giới tính, tôn giáo, hoặc xu hướng tính dục.',
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Bảo mật Dữ liệu Cá nhân',
              content:
                  'Tuyệt đối không được yêu cầu hoặc chia sẻ bất kỳ Thông tin Nhận dạng Cá nhân (PII) nhạy cảm nào ra bên ngoài nền tảng bảo mật của Tixio (ví dụ: địa chỉ cư trú, thông tin tài chính, mật khẩu)',
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Quy tắc Giao dịch Tài chính',
              content:
                  '• Mọi hoạt động giao dịch tài chính liên quan đến dịch vụ (mua Xu, Đăng ký, Quà tặng) phải được thực hiện thông qua Cổng Thanh toán an toàn tích hợp của Tixio.\n\n• Nghiêm cấm yêu cầu hoặc thực hiện các hình thức chuyển tiền/quà vật chất ngoài ứng dụng. Các giao dịch này không được Tixio bảo hộ và không thuộc phạm vi xử lý khiếu nại.',
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: 'Bảo vệ Sở hữu Trí tuệ (IP)',
              content:
                  'Nội dung Trả phí: Mọi nội dung được bảo vệ bởi tường phí (Paywall) hoặc được đánh dấu là "Riêng tư" đều bị nghiêm cấm sao chép, ghi âm, chụp màn hình hoặc phát tán dưới mọi hình thức. Hành vi này được xem là vi phạm bản quyền và sẽ dẫn đến việc chấm dứt tài khoản ngay lập tức và có thể bị xử lý pháp lý.',
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
        color: const Color(0xFFF5F5F5), // Light grey background
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
