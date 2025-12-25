import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';
import 'package:tixio/search/search_screen.dart';
import 'package:tixio/models/event_model.dart';
import 'package:tixio/data/events_data.dart';

import 'package:tixio/services/firestore_service.dart';

class CategorySection extends StatelessWidget {
  final String title;

  const CategorySection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Map display title to Firebase collection name
    String collectionName = title;
    if (title == "Nhạc sống") collectionName = "nhacsong";
    if (title == "Thể thao") collectionName = "sports";
    
    return StreamBuilder<List<Event>>(
      stream: FirestoreService().getEventsFromCollection(collectionName),
      builder: (context, snapshot) {
        final events = snapshot.data ?? [];

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
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87), 
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
            
            // Error state
            if (snapshot.hasError)
               Center(child: Text("Lỗi: ${snapshot.error}", style: const TextStyle(color: Colors.red))),

            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting)
               const Center(child: Padding(
                 padding: EdgeInsets.all(20.0),
                 child: CircularProgressIndicator(),
               )),

            // Empty state with debug info
            if (snapshot.connectionState != ConnectionState.waiting && events.isEmpty) 
               Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Chưa có dữ liệu trong '$collectionName'...", style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
              ),
              
            if (events.isNotEmpty)
             GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: 1.15,
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
                          borderRadius: BorderRadius.circular(16), 
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
                          color: Color(0xFF013aad), 
                          fontWeight: FontWeight.bold,
                          fontSize: 12, 
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Date
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 12, color: Color(0xFFb11d39)), // Red icon
                        const SizedBox(width: 4),
                        Text(
                          event.dateOnly,
                          style: const TextStyle(
                            color: Color(0xFFb11d39), 
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
          ],
        );
      }
    );
  }
}
