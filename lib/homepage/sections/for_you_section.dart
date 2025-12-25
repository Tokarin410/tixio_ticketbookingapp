import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';
import 'package:tixio/search/search_screen.dart';
import 'package:tixio/data/events_data.dart';
import 'package:tixio/models/event_model.dart';

class ForYouSection extends StatelessWidget {
  final bool showHeader;
  const ForYouSection({super.key, this.showHeader = true});

  @override
  Widget build(BuildContext context) {
    // Real Data - Limit to 4 items as requested
    final List<Event> events = allEvents.take(4).toList(); 

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
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const SearchScreen())
                  );
                },
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
        
        events.isEmpty 
        ? const Padding(
             padding: EdgeInsets.all(16.0),
             child: Text("Đang cập nhật sự kiện..."),
          )
        : GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 1.15, // Match My Ticket
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinSuKienScreen(event: event)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                // Image
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16), // Radius 16
                      image: DecorationImage(
                        image: AssetImage(event.posterImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                SizedBox(
                  height: 32,
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      color: Color(0xFF013aad), // Blue title
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Reduced to 12
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                // Date
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 12, color: Color(0xFFA51C30)), // Red icon
                    const SizedBox(width: 4),
                    Text(
                      event.dateOnly,
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
          height: 150, // Increased height for better visibility
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
             image: const DecorationImage(
                image: AssetImage('assets/images/bannerquangcao.png'), 
                fit: BoxFit.fill, // Ensure it fills the container completely
             ),
          ),
        ),
      ],
    );
  }
}
