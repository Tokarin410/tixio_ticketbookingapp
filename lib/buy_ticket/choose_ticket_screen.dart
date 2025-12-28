import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/buy_ticket/payment_info_screen.dart';
import 'package:tixio/buy_ticket/widgets/ticket_stepper.dart';
import 'package:tixio/models/event_model.dart';
import 'package:intl/intl.dart';
import 'package:tixio/services/firestore_service.dart';

class ChooseTicketScreen extends StatefulWidget {
  final Event event;
  const ChooseTicketScreen({super.key, required this.event});

  @override
  State<ChooseTicketScreen> createState() => _ChooseTicketScreenState();
}

class _ChooseTicketScreenState extends State<ChooseTicketScreen> {
  // Map to store counts for each tier index
  final Map<int, int> ticketCounts = {};
  late Stream<Event> _eventStream;

  @override
  void initState() {
    super.initState();
    _eventStream = FirestoreService().getEventStream(widget.event.id, widget.event.category, collectionName: widget.event.collectionName);
    // Initialize counts to 0
    for (int i = 0; i < widget.event.ticketTiers.length; i++) {
        ticketCounts[i] = 0;
    }
  }

  int getTotalAmount(Event event) {
    int total = 0;
    for (int i = 0; i < event.ticketTiers.length; i++) {
        // Price is now double in model, cast to int for total calculation
        int price = event.ticketTiers[i].price.toInt();
        total += (ticketCounts[i] ?? 0) * price; 
    }
    return total;
  }

  // Helper to format currency
  String formatCurrency(int amount) {
    final currencyFormatter = NumberFormat("#,##0", "vi_VN");
    return "${currencyFormatter.format(amount)}đ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Keeping light grey bg for contrast
      appBar: AppBar(
        title: Text(
          "Chọn vé",
          style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder<Event>(
        stream: _eventStream,
        initialData: widget.event,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
             return Center(child: Text("Lỗi: ${snapshot.error}\nAllocated Collection: ${widget.event.collectionName}\nID: ${widget.event.id}", textAlign: TextAlign.center));
          }
          
          // Use the latest event data
          final event = snapshot.data ?? widget.event;
          final total = getTotalAmount(event);
          
          // Safe Date Parsing Logic
          String day = "??";
          String month = "??";
          try {
             if (event.dateOnly.contains('/')) {
                 final parts = event.dateOnly.split('/');
                 if (parts.length >= 2) {
                     day = parts[0];
                     month = parts[1];
                 }
             } else if (event.dateOnly.toLowerCase().contains('tháng')) {
                 // Handle "30 tháng 12, 2025" format
                 final parts = event.dateOnly.trim().split(' ');
                 if (parts.length >= 3) {
                     day = parts[0];
                     month = parts[2].replaceAll(',', '');
                 }
             } else {
                 // Fallback simple split by space if seemingly valid
                 final parts = event.dateOnly.trim().split(' ');
                 if (parts.length >= 1) day = parts[0];
             }
          } catch (_) {
             // Keep default "??", avoid crash
          }


          return Column(
            children: [
              // 1. Progress Bar
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: const TicketStepper(currentStep: 1),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. Info Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                             BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                          ]
                        ),
                        child: Row(
                          children: [
                            // Date Box
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD), // Light Blue
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFBBDEFB)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Tháng $month", style: GoogleFonts.josefinSans(fontSize: 12, color: const Color(0xFF013aad), fontWeight: FontWeight.bold)),
                                  Text(day, style: GoogleFonts.josefinSans(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Text Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style: GoogleFonts.josefinSans(fontWeight: FontWeight.w800, fontSize: 16, height: 1.2),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                      const SizedBox(width: 4),
                                      Expanded(child: Text(event.location, style: GoogleFonts.josefinSans(fontSize: 14, color: Colors.grey[700]), overflow: TextOverflow.ellipsis)),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),

                      // 3. Seat Map
                      Text("Sơ đồ chỗ ngồi", style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: (event.seatMapImage != null && event.seatMapImage!.isNotEmpty)
                            ? Image.asset(
                                event.seatMapImage!, 
                                width: double.infinity,
                                fit: BoxFit.fitWidth, 
                                errorBuilder: (context, error, stackTrace) => _buildNoMapPlaceholder(),
                              )
                            : _buildNoMapPlaceholder(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 4. Ticket List - Dynamic
                       Text("Chọn loại vé", style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
                       const SizedBox(height: 12),
                      ...List.generate(event.ticketTiers.length, (index) {
                          final tier = event.ticketTiers[index];
                          // Use consistent palette matching Event Details screen
                          List<Color> tierColors = [
                            const Color(0xFF00C853), // Green
                            const Color(0xFFFFD600), // Yellow
                            const Color(0xFFFF6D00), // Orange
                            const Color(0xFF2962FF), // Blue
                            const Color(0xFFD50000), // Red
                            const Color(0xFFAA00FF), // Purple
                          ];
                          Color tierColor = tierColors[index % tierColors.length];
                          
                          return _buildTicketRow(
                            tier.name,
                            tier.price.toInt(),
                            ticketCounts[index] ?? 0,
                            tierColor,
                            tier.available, // Use available quantity
                            (val) => setState(() => ticketCounts[index] = val)
                          );
                      }),

                      const SizedBox(height: 100), // Bottom spacer
                    ],
                  ),
                ),
              ),
              
              // 5. Bottom Bar
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0,-5))],
                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                 ),
                 child: SafeArea(
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       // Total Row
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Tổng tiền", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54)),
                           Text(formatCurrency(total), style: GoogleFonts.josefinSans(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFFb11d39))),
                         ],
                       ),
                       const SizedBox(height: 16),
                       ElevatedButton(
                         onPressed: total > 0 ? () {
                            // Gather selected tickets
                            List<String> selectedTickets = [];
                            for(int i=0; i<event.ticketTiers.length; i++) {
                               int count = ticketCounts[i] ?? 0;
                               if(count > 0) {
                                   selectedTickets.add("${event.ticketTiers[i].name} x$count");
                               }
                            }
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentInfoScreen(
                              amount: formatCurrency(total),
                              ticketInfo: selectedTickets.join(", "),
                              event: event, // Pass event
                            )));
                         } : null,
                         style: ElevatedButton.styleFrom(
                           backgroundColor: const Color(0xFF013aad),
                           minimumSize: const Size(double.infinity, 54),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                           disabledBackgroundColor: Colors.grey[300],
                           elevation: 0,
                         ),
                         child: Text("Tiếp tục", style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                       )
                     ],
                   ),
                 ),
              ),
            ],
          );
        }
      ),
    );
  }

  Widget _buildNoMapPlaceholder() {
    return Container(
      height: 200, 
      color: Colors.grey[100], 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text("Chưa cập nhật sơ đồ", style: GoogleFonts.josefinSans(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketRow(String title, int price, int count, Color color, int available, Function(int) onChanged) {
      final currencyFormatter = NumberFormat("#,##0", "vi_VN");
      String priceStr = (price == 0) ? "Miễn Phí" : "${currencyFormatter.format(price)}đ";
      bool isSoldOut = available <= 0;
      
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: Colors.grey.shade200),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))]
        ),
        child: Row(
          children: [
            // Color strip
            Container(
              width: 5,
              height: 50,
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 17, color: const Color(0xFF013aad))),
                  const SizedBox(height: 4),
                  Text(priceStr, style: GoogleFonts.josefinSans(color: const Color(0xFFb11d39), fontWeight: FontWeight.w600, fontSize: 15)),
                ],
              ),
            ),
            
            // Counter or Sold Out
            isSoldOut 
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF8A80), // Light red/pink per request "Hết vé"
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Hết vé",
                  style: GoogleFonts.josefinSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200)
                ),
                child: Row(
                  children: [
                     IconButton(
                       icon: Icon(Icons.remove, color: count > 0 ? const Color(0xFF013aad) : Colors.grey, size: 20),
                       onPressed: count > 0 ? () => onChanged(count - 1) : null,
                       constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                       splashRadius: 20,
                     ),
                     SizedBox(
                       width: 30, 
                       child: Text("$count", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 16))
                     ),
                     IconButton(
                       icon: const Icon(Icons.add, color: Color(0xFF013aad), size: 20),
                       onPressed: count < available ? () => onChanged(count + 1) : null,
                       constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                       splashRadius: 20,
                     ),
                  ],
                ),
              )
          ],
        ),
      );
  }
}
