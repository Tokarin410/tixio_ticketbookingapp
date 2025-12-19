import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final String title;

  const CategorySection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Mock data based on the provided image
    final List<Map<String, String>> events = title == "Nhạc sống"
        ? [
            {
              "title": "[BẾN THÀNH] Đêm nhạc Hoàng Hải - Uyên Linh",
              "date": "27 Tháng 12, 2025",
              "image": "assets/images/poster_test.png"
            },
            {
              "title": "[HBSO] HÒA NHẠC GIÁNG SINH",
              "date": "25 Tháng 12, 2025",
              "image": "assets/images/poster_test.png"
            },
          ]
        : [
            {
              "title": "CHUNG KẾT ĐTDV MÙA ĐÔNG 2025",
              "date": "27 Tháng 12, 2025",
              "image": "assets/images/poster_test.png"
            },
            {
              "title": "VIETNAM BASKETBALL CHAMPIONSHIP 2025",
              "date": "25 Tháng 12, 2025",
              "image": "assets/images/poster_test.png"
            },
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87), // Bigger title
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
            childAspectRatio: 0.75,
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), // More rounded
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
                    color: Color(0xFF013aad), // Blue title per user request
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
                    const Icon(Icons.calendar_today, size: 12, color: Color(0xFFb11d39)), // Red icon
                    const SizedBox(width: 4),
                    Text(
                      event["date"]!,
                      style: const TextStyle(
                        color: Color(0xFFb11d39), // Red date text per user request
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
