import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF013aad),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "About us",
          style: GoogleFonts.josefinSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Overview
            _buildSectionTitle("Tổng quan"),
            const SizedBox(height: 12),
            Text(
              "Tixio là ứng dụng di động đặt vé sự kiện trực tuyến được phát triển trên nền tảng Flutter kết hợp với Firebase. Dự án nhằm cung cấp giải pháp mua vé nhanh chóng và tiện lợi, giải quyết các bất cập của phương thức mua vé truyền thống. Ứng dụng tích hợp đầy đủ các tính năng hiện đại như: tìm kiếm và lọc sự kiện thông minh theo thời gian thực (real-time), đặt chỗ trực quan và quản lý vé điện tử cá nhân. Thông qua dự án, nhóm mong muốn áp dụng các kỹ thuật lập trình di động tiên tiến để tối ưu hóa trải nghiệm người dùng trong lĩnh vực giải trí số.",
              style: GoogleFonts.josefinSans(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
             const SizedBox(height: 24),

            // 2. Design System
            _buildSectionTitle("Design system"),
            const SizedBox(height: 12),
            
            // Colors & Typography
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Colors
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color pallete", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12), // Added spacing since labels are gone
                      Row(
                        children: [
                           _buildColorBox(const Color(0xFF013aad), "#013AAD"),
                           const SizedBox(width: 8),
                           _buildColorBox(Colors.white, "#FFFFFF", hasBorder: true),
                           const SizedBox(width: 8),
                           _buildColorBox(const Color(0xFFB11D39), "#B11D39"),
                        ],
                      )
                    ],
                  ),
                ),
                // Typography
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Typography", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text("Aa", style: GoogleFonts.josefinSans(fontSize: 40, fontWeight: FontWeight.bold)),
                      Text("JOSEFIN SANS", style: GoogleFonts.josefinSans(fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            
            // Logos
             Text("Our logo", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold)),
             const SizedBox(height: 8),
             Row(
               children: [
                 Container(
                   width: 100, height: 100,
                   decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                   padding: const EdgeInsets.all(8),
                   child: Image.asset('assets/images/logotixio.png', fit: BoxFit.contain),
                 ),
                 const SizedBox(width: 16),
                 Container(
                   width: 100, height: 100,
                   color: const Color(0xFF013aad),
                   padding: const EdgeInsets.all(8),
                   child: Image.asset('assets/images/logotixio_white.png', fit: BoxFit.contain),
                 ),
               ],
             ),
             const SizedBox(height: 30),

            // 3. Team
            _buildSectionTitle("Our Teams - Tixio"),
             const SizedBox(height: 16),
            _buildTeamTable(),
            
            const SizedBox(height: 40),
            
            // Footer Logos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Logo/Logo_UEH_xanh.png', height: 50),
                const SizedBox(width: 16),
                Image.asset('assets/images/Logo/logoUII.webp', height: 40), // Reduced
                const SizedBox(width: 16),
                Image.asset('assets/images/logotixio.png', height: 100), // Increased further
              ],
            ),
             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.josefinSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFB11D39), // Red title
        ),
      ),
    );
  }

  Widget _buildColorBox(Color color, String hex, {bool hasBorder = false}) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            border: hasBorder ? Border.all(color: Colors.grey.shade300) : null,
            borderRadius: BorderRadius.circular(4)
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hex, 
          style: GoogleFonts.josefinSans(fontSize: 10, color: Colors.grey[700])
        ),
      ],
    );
  }

  Widget _buildTeamTable() {
    return Column(
      children: [
        // Header
        Row(
          children: [
             Expanded(child: _buildCell("Họ và tên", isHeader: true, borderColor: const Color(0xFF013aad), textColor: const Color(0xFFB11D39))),
             const SizedBox(width: 10),
             Expanded(child: _buildCell("MSSV", isHeader: true, borderColor: const Color(0xFF013aad), textColor: const Color(0xFFB11D39))),
          ],
        ),
        const SizedBox(height: 10),
        // Rows
        _buildTeamRow("Phan Khánh Nam *", "31231022603"),
        const SizedBox(height: 8),
        _buildTeamRow("Nguyễn Võ Hoàng Nhật", "31231025613"),
        const SizedBox(height: 8),
        _buildTeamRow("Vũ Nguyễn Minh Quân", "31231023118"),
        const SizedBox(height: 8),
        _buildTeamRow("Nguyễn Hà My", "31231027835"),
      ],
    );
  }

  Widget _buildTeamRow(String name, String id) {
     return Row(
          children: [
             Expanded(child: _buildCell(name, bg: const Color(0xFF013aad), textColor: Colors.white)),
             const SizedBox(width: 10),
             Expanded(child: _buildCell(id, bg: const Color(0xFFB11D39), textColor: Colors.white)),
          ],
     );
  }

  Widget _buildCell(String text, {bool isHeader = false, Color? bg, Color? borderColor, Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg ?? Colors.white,
        border: Border.all(color: borderColor ?? Colors.transparent, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: GoogleFonts.josefinSans(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: textColor ?? (isHeader ? Colors.black : Colors.white),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
