import 'package:flutter/material.dart';


class NavigationBottom extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavigationBottom({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // Helper static method for navigation from other screens if needed
  static void navigateFrom(BuildContext context) {
      // This is a placeholder for logic if we want to ensure specific state reset
      // or if we implement a root navigation controller later.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF013aad), // Main Blue
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14), // Boldest weight
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
          iconSize: 30,
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.home_filled),
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.confirmation_num_outlined),
              ),
              activeIcon: Padding(
                 padding: EdgeInsets.only(bottom: 4.0),
                 child: Icon(Icons.confirmation_num),
              ),
              label: 'Vé của tôi',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.person_outline),
              ),
               activeIcon: Padding(
                 padding: EdgeInsets.only(bottom: 4.0),
                 child: Icon(Icons.person),
              ),
              label: 'Tài khoản',
            ),
          ],
        ),
      ),
    );
  }
}
