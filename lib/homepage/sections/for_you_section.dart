import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';

class ForYouSection extends StatelessWidget {
  final bool showHeader;
  const ForYouSection({super.key, this.showHeader = true});

  @override
  Widget build(BuildContext context) {
    // Mock Data based on user image
    final List<Map<String, String>> events = [
      {
        "title": "ANH TRAI \"SAY HI\" 2025 CONCERT",
        "date": "27 Tháng 12, 2025",
        "image": "assets/images/poster_test.png"
      },
      {
         "title": "Y-CONCERT - MÌNH ĐOÀN VIÊN THÔI",
         "date": "25 Tháng 12, 2025",
         "image": "assets/images/poster_test.png"
      },
      {
         "title": "CHỊ ĐẸP ĐẠP GIÓ CONCERT 2025",
         "date": "30 Tháng 12, 2025",
         "image": "assets/images/poster_test.png"
      },
      {
         "title": "ANH TRAI VƯỢT NGÀN CHÔNG GAI ENCORE",
         "date": "31 Tháng 12, 2025",
         "image": "assets/images/poster_test.png"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dành cho bạn",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87), // Increased font size
              ),
              GestureDetector(
                onTap: () {},
                child: const Row(
                  children: [
                    Text("Xem thêm", style: TextStyle(color: Colors.grey, fontSize: 14)),
                    Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                  ],
                ),
              )
            ],
          ),
        ),
        
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75, // Adjust for card height
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ThongTinSuKienScreen()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // Image
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(event["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                Text(
                  event["title"]!,
                  style: const TextStyle(
                    color: Color(0xFF013aad), // Blue title
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Date
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 12, color: Color(0xFFA51C30)), // Red icon
                    const SizedBox(width: 4),
                    Text(
                      event["date"]!,
                      style: const TextStyle(
                        color: Color(0xFFA51C30), // Red date text
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
             ),
            );
          },
        ),

        const SizedBox(height: 20),
        // Ad Banner
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 120, // Increased height for banner
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(12),
             image: const DecorationImage(
                image: AssetImage('assets/images/bannerquangcao.png'), 
                fit: BoxFit.cover,
             ),
          ),
          child: const Center(child: Text("Ad Banner Placeholder", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ),
      ],
    );
  }
}
