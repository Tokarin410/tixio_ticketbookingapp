import 'package:flutter/material.dart';

class MonthFilter extends StatefulWidget {
  const MonthFilter({super.key});

  @override
  State<MonthFilter> createState() => _MonthFilterState();
}

class _MonthFilterState extends State<MonthFilter> {
  int _selectedIndex = 0; // 0: This month, 1: Next month

  @override
  @override
  Widget build(BuildContext context) {
    // Data for "Tháng này"
    final List<Map<String, String>> thisMonthEvents = [
      {
        "title": 'ANH TRAI "SAY HI" 2025 CONCERT',
        "date": "27/12/2025",
        "location": "TP. HCM",
        "image": "assets/images/Poster ngang/ATSH.png"
      },
      {
        "title": "Y-CONCERT - MÌNH ĐOÀN VIÊN THÔI",
        "date": "25/12/2025",
        "location": "TP. HCM",
        "image": "assets/images/Poster ngang/Ycon.jpg"
      },
    ];

    // Data for "Tháng sau"
    final List<Map<String, String>> nextMonthEvents = [
      {
        "title": "CHỊ ĐẸP ĐẠP GIÓ CONCERT 2025",
        "date": "05/01/2026",
        "location": "Hà Nội",
        "image": "assets/images/Poster ngang/CDDG.jpg"
      },
      {
        "title": "EM XINH CONCERT",
        "date": "12/01/2026",
        "location": "Đà Nẵng",
        "image": "assets/images/Poster ngang/EMXINH.jpg" // Fallback if not verified, but listed in step 1178
      },
    ];

    final events = _selectedIndex == 0 ? thisMonthEvents : nextMonthEvents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              _buildFilterButton("Tháng này", 0),
              const SizedBox(width: 16),
              _buildFilterButton("Tháng sau", 1),
            ],
          ),
        ),
        
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              // Remove fixed height to let content size it, or keep it if design requires. 
              // Placeholder had 200. Let's start with auto height Column.
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                   BoxShadow(
                      color: Colors.black.withOpacity(0.05), // Lighter shadow
                      blurRadius: 8,
                      offset: const Offset(0, 4)
                   )
                ]
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Image.asset(
                            event["image"]!,
                            height: 150, // Fixed height for image part
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                      event["title"]!, 
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                         const Icon(Icons.calendar_today, size: 14, color: Color(0xFFb11d39)),
                                         const SizedBox(width: 4),
                                         Text(event["date"]!, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                                         const SizedBox(width: 12),
                                         const Icon(Icons.location_on, size: 14, color: Color(0xFFb11d39)),
                                         const SizedBox(width: 4),
                                         Text(event["location"]!, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                                      ],
                                    )
                                ]
                            )
                          )
                      ]
                  )
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildFilterButton(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14, // Adjusted per user screenshot (looks smaller than 16)
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF4A68F0) : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
           Container(
            height: 3,
            width: 30, // Shorter line
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4A68F0) : Colors.transparent,
              borderRadius: BorderRadius.circular(2)
            ),
          ),
        ],
      ),
    );
  }
}
