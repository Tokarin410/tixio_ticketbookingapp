import 'package:flutter/material.dart';

class ZigZagBackground extends StatelessWidget {
  const ZigZagBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top zig-zag
        SizedBox(
          width: double.infinity,
           child: Image.asset(
            "assets/images/zigzac.png",
            fit: BoxFit.fill, // Ensure it stretches across
            height: 50, // Adjust height as per design, looks like a thin strip
          ),
        ),
        const Spacer(),
        // Bottom zig-zag
        SizedBox(
           width: double.infinity,
           child: Image.asset(
            "assets/images/zigzac.png",
            fit: BoxFit.fill,
            height: 50, 
          ),
        ),
      ],
    );
  }
}
