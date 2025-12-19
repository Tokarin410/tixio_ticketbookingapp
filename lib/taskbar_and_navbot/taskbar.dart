import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketcon/widgets/tixio_logo.dart';

class Taskbar extends StatelessWidget {
  const Taskbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF013aad), // Blue background
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero), // Rectangular drawer
      child: SafeArea(
        child: Column(
          children: [
            // Header with Logo
            Container(
              height: 240, // Increased height
              width: double.infinity,
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8), // Reduced padding to fit
              child: Row(
                children: [
                   IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF013aad), size: 30), // Blue menu icon
                      onPressed: () {
                        Navigator.pop(context); // Close drawer
                      },
                    ),
                  Expanded(
                    child: Center(
                       child: const TixioLogo(size: 180), // Slightly smaller to fit
                    ),
                  ),
                   const SizedBox(width: 48), // Balance the left IconButton (48px default)
                ],
              ),
            ),
            
            // Menu Items
            // Removed SizedBox to remove gap
             _buildDivider(),
            // Let's follow: Item -> Divider.
            _buildMenuItem(
              icon: Icons.people, 
              text: "About us", 
              onTap: () {
                // Placeholder for About Us
              }
            ),
            _buildDivider(),
             _buildMenuItem(
              icon: Icons.assignment, 
              text: "Hướng dẫn", 
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/safety_instructions');
              }
            ),
            _buildDivider(),
             _buildMenuItem(
              icon: Icons.menu_book, 
              text: "Quy định", 
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/regulations');
              }
            ),
            _buildDivider(),
             _buildMenuItem(
              icon: Icons.bug_report, 
              text: "Báo cáo sự cố", 
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/report_incident');
              }
            ),
            _buildDivider(),
             _buildMenuItem(
              icon: Icons.notifications, 
              text: "Thông báo", 
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/notifications');
              }
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 30),
      title: Text(
        text,
        style: GoogleFonts.josefinSans( // Updated to global font
          color: Colors.white,
          fontSize: 20, // Slightly bigger text
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.white, // Solid white
      thickness: 1.5, // Thicker
      height: 1,
      indent: 0, // Full width
      endIndent: 0,
    );
  }
}
