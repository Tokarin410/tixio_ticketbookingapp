import 'package:flutter/material.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';

class SpecialEvents extends StatelessWidget {
  const SpecialEvents({super.key});

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
            itemCount: 5,
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
                    color: Colors.blueGrey[100],
                  ),
                  child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            color: Colors.grey
                        ),
                        // child: Image.asset(...), // Placeholder
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          child: const Text("Special Event Info", textAlign: TextAlign.center, style: TextStyle(fontSize: 12))
                      ),
                    ),
                  ],
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
