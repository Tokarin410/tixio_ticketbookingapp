import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';

class TrendingEvents extends StatefulWidget {
  const TrendingEvents({super.key});

  @override
  State<TrendingEvents> createState() => _TrendingEventsState();
}

class _TrendingEventsState extends State<TrendingEvents> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.pinkAccent), // Fire icon pink per design
                SizedBox(width: 8),
                Text(
                  "Sự kiện xu hướng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200, 
            child: PageView.builder(
              itemCount: 5, // Increased to 5 slides
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ThongTinSuKienScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300], 
                      image: const DecorationImage(
                        image: AssetImage('assets/images/poster_test.png'), 
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(child: Text("Event ${index + 1}", style: const TextStyle(color: Colors.white))),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20), // Padding bottom inside card
          // Indicator dots
           Center(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: List.generate(5, (index) => AnimatedContainer(
                 duration: const Duration(milliseconds: 300),
                 margin: const EdgeInsets.symmetric(horizontal: 3),
                 width: _currentIndex == index ? 10 : 8, // Active dot size
                 height: 8,
                 decoration: BoxDecoration(
                   color: _currentIndex == index ? const Color(0xFF013aad) : Colors.grey[300], // Active dot color
                   borderRadius: BorderRadius.circular(4),
                 ),
               )),
             ),
           ),
           const SizedBox(height: 16),
        ],
      ),
    );
  }
}
