import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';
import 'package:tixio/data/events_data.dart'; // import allEvents
import 'package:tixio/models/event_model.dart'; // import Event model

class SpecialEvents extends StatelessWidget {
  const SpecialEvents({super.key});

  @override
  Widget build(BuildContext context) {
    // Pick some events for Special Events section
    List<Event> specialEvents = allEvents.length > 5 ? allEvents.sublist(1, 6) : allEvents;

    if (specialEvents.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Sự kiện đặc biệt",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
        SizedBox(
          height: 250, // Height for vertical posters
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: specialEvents.length,
            itemBuilder: (context, index) {
              final event = specialEvents[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinSuKienScreen(event: event)));
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: AssetImage(event.bannerImage ?? event.posterImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
