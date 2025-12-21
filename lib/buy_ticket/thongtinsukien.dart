import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThongTinSuKienScreen extends StatefulWidget {
  const ThongTinSuKienScreen({super.key});

  @override
  State<ThongTinSuKienScreen> createState() => _ThongTinSuKienScreenState();
}

class _ThongTinSuKienScreenState extends State<ThongTinSuKienScreen> {
  bool _isEventInfoExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Chi tiết sự kiện",
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
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
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Image.asset(
              "assets/images/ticket_banner_1.jpg", // Placeholder
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200, 
                color: Colors.grey[300], 
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'ANH TRAI "SAY HI" 2025 CONCERT',
                    style: GoogleFonts.josefinSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Info Rows
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 24, color: Colors.grey[700]), 
                      const SizedBox(width: 12),
                      Text(
                        "12:00 - 23:00, 27 tháng 12, 2025",
                        style: GoogleFonts.josefinSans(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 24, color: Colors.grey[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Khu đô thị Vạn Phúc",
                              style: GoogleFonts.josefinSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Khu đô thị Vạn Phúc, Phường Hiệp Bình Phước, Quận Thủ Đức, Thành Phố Hồ Chí Minh",
                              style: GoogleFonts.josefinSans(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey[600], height: 1.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 16),
                   
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.local_offer, size: 24, color: Colors.grey[700]),
                      const SizedBox(width: 12),
                      Text(
                        "800.000 đ - 10.000.000 đ",
                        style: GoogleFonts.josefinSans(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  
                  const Text("Ban tổ chức", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/BTC/vieon.png",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(color: Colors.pink, width: 50, height: 50),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Vie Channel", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 2),
                          const Text("VieChannel Đơn vị sản xuất", style: TextStyle(fontSize: 13, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Event Info Section
                  GestureDetector(
                    onTap: () {
                      setState(() {
                         _isEventInfoExpanded = !_isEventInfoExpanded;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF013aad),
                        borderRadius: _isEventInfoExpanded 
                            ? const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                            : BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thông tin sự kiện",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            _isEventInfoExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
                            color: Colors.white
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isEventInfoExpanded)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1), // Lighter border
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: Colors.white,
                        boxShadow: [
                           BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: const Offset(0,2)),
                        ]
                      ),
                      child: const Text(
                        "Concert Anh Trai \"Say Hi\" 2025 sẽ diễn ra vào ngày 27/12/2025 tại Khu đô thị Vạn Phúc City (TP. Hồ Chí Minh), kéo dài 11 tiếng với sân khấu quy mô lớn, công nghệ DMX hiện đại, trình diễn các ca khúc Top Trending, quy tụ dàn \"Anh Trai\" hot nhất như Negav, B Ray, Bùi Trường Linh, Song Luân, HIEUTHUHAI, HURRYKNG, ...\nGiá vé từ 800k - 10tr VNĐ, hứa hẹn mang đến trải nghiệm âm nhạc đỉnh cao cho khán giả.",
                        style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Ticket Info Section
                  _buildSectionHeader("Thông tin vé"),
                  const SizedBox(height: 10),
                  
                  _buildTicketTier(context, "Hạng A", "10.000.000đ", true, [
                     "KHU VỰC DÀNH CHO NGƯỜI THAM DỰ TỪ ĐỦ 18 TUỔI\nPREMIUM SERVICES*",
                     "01 Vé vào cổng khu vực SKY LOUNGE (NGỒI)",
                     "Cơ hội tham dự SOUNDCHECK (theo sự sắp xếp của BTC) Ngẫu nhiên 50 khách hàng",
                     "Cơ hội tham dự GROUP PHOTO (theo sự sắp xếp của BTC) Ngẫu nhiên 50 khách hàng",
                     "Quà tặng: 01 Quà tặng phiên bản đặc biệt - Áo thun \"Say Hi\"",
                  ]),
                  const SizedBox(height: 10),
                  _buildTicketTier(context, "Hạng B", "8.000.000đ", false, []),
                  const SizedBox(height: 10),
                  _buildTicketTier(context, "Hạng C", "2.000.000đ", false, []),
                  
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0,-5))],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF013aad),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            "Đặt vé ngay",
            style: GoogleFonts.josefinSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF013aad),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: GoogleFonts.josefinSans(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTicketTier(BuildContext context, String title, String price, bool isExpanded, List<String> details) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          title: Row(
            children: [
              Container(width: 4, height: 20, color: Colors.green), // Color bar indicator
              const SizedBox(width: 8),
              Text(title, style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 16)),
              const Spacer(),
              Text(price, style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text("- $e", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
