import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/buy_ticket/choose_ticket_screen.dart';
import 'package:tixio/models/event_model.dart';
import 'package:intl/intl.dart';

class ThongTinSuKienScreen extends StatefulWidget {
  final Event event;
  const ThongTinSuKienScreen({super.key, required this.event});

  @override
  State<ThongTinSuKienScreen> createState() => _ThongTinSuKienScreenState();
}

class _ThongTinSuKienScreenState extends State<ThongTinSuKienScreen> {
  bool _isEventInfoExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Chi tiết sự kiện",
          style: GoogleFonts.josefinSans(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner (using posterImage as banner fallback or just poster)
            // Model doesn't have bannerImage anymore, let's use posterImage or placeholder
            widget.event.posterImage.isNotEmpty 
            ? Image.asset(
              widget.event.posterImage, 
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200, 
                color: Colors.grey[300], 
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            )
            : Container(
                height: 200, 
                color: Colors.grey[300], 
                child: const Center(child: Icon(Icons.image_not_supported)),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.event.title,
                    style: GoogleFonts.josefinSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Info Rows
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_month, size: 24, color: Colors.grey[700]), 
                      const SizedBox(width: 12),
                      Text(
                        widget.event.dateTime,
                        style: GoogleFonts.josefinSans(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on, size: 24, color: Colors.grey[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.location, // Updated property
                              style: GoogleFonts.josefinSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            // Removed address subtitle as it's merged or not in data
                          ],
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 16),
                   
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.local_offer, size: 24, color: Colors.grey[700]),
                      const SizedBox(width: 12),
                      Text(
                        widget.event.priceRange,
                        style: GoogleFonts.josefinSans(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  
                  const Text("Ban tổ chức", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget.event.organizer.logoAsset.isNotEmpty 
                          ? Image.asset(
                              widget.event.organizer.logoAsset,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(color: Colors.pink, width: 50, height: 50),
                            )
                          : Container(color: Colors.pink, width: 50, height: 50),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.organizer.name, 
                              style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(widget.event.organizer.role, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      )
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Event Info Section
                  GestureDetector(
                    onTap: () {
                      setState(() {
                         _isEventInfoExpanded = !_isEventInfoExpanded;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF013aad),
                        borderRadius: _isEventInfoExpanded 
                            ? const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                            : BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thông tin sự kiện",
                            style: GoogleFonts.josefinSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            _isEventInfoExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, 
                            color: Colors.white
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isEventInfoExpanded)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1), // Lighter border
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: Colors.white,
                        boxShadow: [
                           BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, offset: const Offset(0,2)),
                        ]
                      ),
                      child: Text(
                        widget.event.description,
                        style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Ticket Info Section - Dynamic
                  _buildSectionHeader("Thông tin vé"),
                  const SizedBox(height: 10),
                  
                  if (widget.event.ticketTiers.isEmpty)
                     const Text("Sự kiện miễn phí hoặc chưa cập nhật vé.", style: TextStyle(fontStyle: FontStyle.italic)),

                  ...widget.event.ticketTiers.asMap().entries.map((entry) {
                     int index = entry.key;
                     var tier = entry.value;
                     // Format price double to string
                     final currencyFormatter = NumberFormat("#,##0", "vi_VN");
                     String priceStr = (tier.price == 0) ? "Miễn Phí" : "${currencyFormatter.format(tier.price)}đ";
                     
                     // Distinct colors for tiers
                     List<Color> tierColors = [
                        const Color(0xFF00C853), // Green
                        const Color(0xFFFFD600), // Yellow
                        const Color(0xFFFF6D00), // Orange
                        const Color(0xFF2962FF), // Blue
                        const Color(0xFFD50000), // Red
                        const Color(0xFFAA00FF), // Purple
                     ];
                     Color color = tierColors[index % tierColors.length];
                     
                     return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildTicketTier(context, tier.name, priceStr, false, tier.benefits, color),
                    );
                  }),
                  
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0,-5))],
        ),
        child: SafeArea(
            child: widget.event.isEventEnded
            ? Container(
               width: double.infinity,
               height: 56, // Match standard button height
               alignment: Alignment.center,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.grey.shade400, width: 1.5),
               ),
               child: Text(
                 "Sự kiện đã kết thúc",
                 style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
               ),
            )
            : ElevatedButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseTicketScreen(event: widget.event)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF013aad),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                "Đặt vé ngay",
                style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.josefinSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTicketTier(BuildContext context, String title, String price, bool isSoldOut, List<String> benefits, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD).withOpacity(0.5), // Light blue background like design
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      clipBehavior: Clip.hardEdge, // Ensure ripple effect and bg color are clipped
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // Remove divider line
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          collapsedBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 28), // Arrow on left
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start, // Align top for multi-line
            children: [
              // Title Section with Flexible width
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4, 
                      height: 24, 
                      margin: const EdgeInsets.only(top: 2), // Align visually with text
                      decoration: BoxDecoration(
                        color: color, 
                        borderRadius: BorderRadius.circular(2)
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        title, 
                        style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Price Section
              Text(
                price, 
                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)
              ),
            ],
          ),
          trailing: const SizedBox(), // Hide default trailing arrow
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: benefits.map((benefit) => Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    benefit, 
                    style: GoogleFonts.josefinSans(fontSize: 14, color: Colors.black54, height: 1.3)
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
