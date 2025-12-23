import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/vecuatoi/ticket_detail_screen.dart';
import 'package:tixio/vecuatoi/empty_ticket_state.dart';

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({super.key});

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool hasTickets = false; // Toggle this to see filled state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header SECTION
          // Header SECTION
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 10), // Reduced bottom padding, adjusted top
            decoration: const BoxDecoration(
              color: Color(0xFF013aad),
              // borderRadius: BorderRadius.zero, // Removed rounded corners as requested
            ),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Vé của tôi",
                        style: GoogleFonts.josefinSans(
                          fontSize: 20, // Reduced from 24
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10), // Reduced from 15
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 0.5, // Thinner line
                        color: Colors.white, 
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15), // Reduced from 25
                // Custom Tab Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 40, // Reduced from 50
                  decoration: BoxDecoration(
                    color: Colors.white24, 
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white12), 
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelColor: const Color(0xFF013aad),
                    unselectedLabelColor: Colors.white,
                    labelStyle: GoogleFonts.josefinSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // Reduced from 16
                    ),
                    tabs: const [
                       Tab(text: "Sắp diễn ra", height: 40), // explicit height? No, TabBar takes container height usually, but let's be safe
                       Tab(text: "Đã kết thúc", height: 40),
                    ],
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    padding: const EdgeInsets.all(4), // Reduced from 5
                    labelPadding: EdgeInsets.zero, 
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUpcomingTickets(),
                _buildPastTickets(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTickets() {
    if (!hasTickets) {
      return const EmptyTicketState();
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildTicketCard(
          title: 'ANH TRAI "SAY HI" 2025 CONCERT',
          date: '12:00 - 23:00, 27 tháng 12, 2025',
          location: 'Khu đô thị Vạn Phúc, TP.HCM',
          quantity: '01',
          ticketClass: 'SVIP A',
          status: 'Thành công',
          statusColor: Colors.green,
          imagePath: 'assets/images/ticket_banner_1.jpg',
        ),
        _buildTicketCard(
          title: 'Y-CONCERT 2025',
          date: '10:00 - 23:00, 25 tháng 12, 2025',
          location: 'VINHOMES OCEAN PARK 3',
          quantity: '01',
          ticketClass: 'S-VIP A',
          status: 'Thành công',
          statusColor: Colors.green,
          imagePath: 'assets/images/ticket_banner_2.jpg',
        ),
      ],
    );
  }


  Widget _buildPastTickets() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
         _buildTicketCard(
          title: 'ANH TRAI "SAY HI" 2025 CONCERT',
          date: '12:00 - 23:00, 27 tháng 12, 2025',
          location: 'Khu đô thị Vạn Phúc, TP.HCM',
          quantity: '01',
          ticketClass: 'SVIP A',
          status: 'Đã diễn ra',
          statusColor: Colors.grey[700]!, // Darker text for visibility on grey bg
          imagePath: 'assets/images/ticket_banner_1.jpg', // Placeholder
          backgroundColor: const Color(0xFFD9D9D9), // Light grey background
        ),
      ],
    );
  }

  // ... _buildTicketCard implementation ...

  Widget _buildInfoRow(String label, String value, {Color labelColor = Colors.grey}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: labelColor, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.w800,
            fontSize: 16, // Larger font size for values like Quantity and Class
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildTicketCard({
    required String title,
    required String date,
    required String location,
    required String quantity,
    required String ticketClass,
    required String status,
    required Color statusColor,
    required String imagePath,
    Color backgroundColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketDetailScreen(
              title: title,
              date: date,
              location: location,
              quantity: quantity,
              ticketClass: ticketClass,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
        // ... (rest of the child content matches existing)
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left side: Event details
              Expanded(
                flex: 65,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.calendar_month, size: 14, color: Colors.black54),
                          const SizedBox(width: 4),
                          const Text(
                            "Ngày tổ chức",
                            style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        date,
                        style: GoogleFonts.josefinSans(fontSize: 12, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.black54),
                           const SizedBox(width: 4),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Địa điểm", style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 2),
                                  Text(
                                    location,
                                    style: GoogleFonts.josefinSans(fontSize: 12, fontWeight: FontWeight.w800),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              // Dashed Line Separator
              SizedBox(
                width: 1, // Thin line
                child: CustomPaint(
                  painter: DashedLineVerticalPainter(),
                ),
              ),
  
              // Right side: Ticket Metadata
              Expanded(
                flex: 30, // Adjusted flex for better proportion
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoRow("Số lượng", quantity, labelColor: Colors.black54),
                      _buildInfoRow("Hạng vé", ticketClass, labelColor: Colors.black54),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           const Text(
                            "Tình trạng",
                            style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500),
                          ),
                           Text(
                            status,
                            style: GoogleFonts.josefinSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: statusColor == Colors.green ? const Color(0xFF00C853) : statusColor, 
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 5, startY = 3; // Adjusted for better spacing
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1.5;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
