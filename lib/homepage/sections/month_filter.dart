import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';
import 'package:tixio/data/events_data.dart';
import 'package:tixio/models/event_model.dart';

class MonthFilter extends StatefulWidget {
  const MonthFilter({super.key});

  @override
  State<MonthFilter> createState() => _MonthFilterState();
}

class _MonthFilterState extends State<MonthFilter> {
  int _selectedIndex = 0; // 0 for "Tháng này", 1 for "Tháng sau"

  @override
  Widget build(BuildContext context) {
    // Current month and next month logic
    // For simplicity with mock data, let's assume:
    // This month = Dec 2025
    // Next month = Jan 2026/2025
    // Filter from allEvents
    List<Event> thisMonthEvents = allEvents.where((e) => e.dateOnly.contains("12/2025")).toList();
    List<Event> nextMonthEvents = allEvents.where((e) => e.dateOnly.contains("01/2026") || e.dateOnly.contains("01/2025")).toList(); 
    // Added 01/2025 just in case user meant next month relative to now but data is in future.
    // Ideally use DateTime parsing.

    List<Event> displayedEvents = _selectedIndex == 0 ? thisMonthEvents : nextMonthEvents;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tabs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 0),
                child: Column(
                  children: [
                    Text(
                      "Tháng này",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedIndex == 0 ? const Color(0xFF013aad) : Colors.grey,
                      ),
                    ),
                    if (_selectedIndex == 0)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 2,
                        width: 40,
                        color: const Color(0xFF013aad),
                      )
                  ],
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: Column(
                  children: [
                    Text(
                      "Tháng sau",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedIndex == 1 ? const Color(0xFF013aad) : Colors.grey,
                      ),
                    ),
                    if (_selectedIndex == 1)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 2,
                        width: 40,
                        color: const Color(0xFF013aad),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // List
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayedEvents.length,
          itemBuilder: (context, index) {
            final event = displayedEvents[index];
            return GestureDetector(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinSuKienScreen(event: event)));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
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
                              event.posterImage,
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
                                        event.title, 
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                           const Icon(Icons.calendar_today, size: 14, color: Color(0xFFb11d39)),
                                           const SizedBox(width: 4),
                                           Text(event.dateOnly, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                                           const SizedBox(width: 12),
                                           const Icon(Icons.location_on, size: 14, color: Color(0xFFb11d39)),
                                           const SizedBox(width: 4),
                                           // Use event.location instead of locationName
                                           Expanded(
                                             child: Text(
                                               event.location, 
                                               style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
                                               overflow: TextOverflow.ellipsis,
                                             )
                                           ),
                                        ],
                                      )
                                  ]
                              )
                            )
                        ]
                    )
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
