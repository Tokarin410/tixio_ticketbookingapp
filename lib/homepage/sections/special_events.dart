import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';

class SpecialEvents extends StatelessWidget {
  const SpecialEvents({super.key});

  final List<String> _posterImages = const [
    'assets/images/Poster dọc/db2d885f8d62de0f2d07a0b8d8137bc4.jpg',
    'assets/images/Poster dọc/images (1).jpg',
    'assets/images/Poster dọc/images (2).jpg',
    'assets/images/Poster dọc/images (3).jpg',
    'assets/images/Poster dọc/images.jpg',
  ];

  @override
  Widget build(BuildContext context) {
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
            itemCount: _posterImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ThongTinSuKienScreen()));
                },
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: AssetImage(_posterImages[index]),
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
