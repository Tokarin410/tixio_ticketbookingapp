import 'package:flutter/material.dart';

class TixioLogo extends StatelessWidget {
  final double size;
  const TixioLogo({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logotixio.png",
      width: size,
      fit: BoxFit.contain,
    );
  }
}
