import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingEvents extends StatefulWidget {
  const TrendingEvents({super.key});

  @override
  State<TrendingEvents> createState() => _TrendingEventsState();
}

class _TrendingEventsState extends State<TrendingEvents> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);
  
  final List<String> _posterImages = [
    'assets/images/Poster ngang/ATSH.png',
    'assets/images/Poster ngang/ATVNCG.jpg',
    'assets/images/Poster ngang/CDDG.jpg',
    'assets/images/Poster ngang/EMXINH.jpg',
    'assets/images/Poster ngang/Ycon.jpg',
  ];

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
              itemCount: _posterImages.length,
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
                      image: DecorationImage(
                        image: AssetImage(_posterImages[index]), 
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: Text(
                                "Xem chi tiết",
                                style: GoogleFonts.josefinSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
