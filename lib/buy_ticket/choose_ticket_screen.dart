import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/buy_ticket/payment_info_screen.dart';
import 'package:tixio/buy_ticket/widgets/ticket_stepper.dart';

class ChooseTicketScreen extends StatefulWidget {
  const ChooseTicketScreen({super.key});

  @override
  State<ChooseTicketScreen> createState() => _ChooseTicketScreenState();
}

class _ChooseTicketScreenState extends State<ChooseTicketScreen> {
  // Ticket Counts
  int countA = 0;
  int countB = 0;
  int countC = 0;

  // Prices
  final int priceA = 10000000;
  final int priceB = 8000000;
  final int priceC = 2000000;

  int get totalAmount => (countA * priceA) + (countB * priceB) + (countC * priceC);

  // Helper to format currency
  String formatCurrency(int amount) {
    // Simple formatter, can use NumberFormat later
    String str = amount.toString();
    // Add dots logic manually for simplicity or use logic
    // Just simple manual replace for specific known lengths or raw string for now
    // Actually let's use a quick regex or manual loop
    // 10000000 -> 10.000.000
    if (amount == 0) return "0đ";
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
       if (i > 0 && (str.length - i) % 3 == 0) {
         buffer.write('.');
       }
       buffer.write(str[i]);
    }
    return "${buffer.toString()}đ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Chọn vé",
          style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF013aad),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [

// ... class definition ...

          // 1. Progress Bar
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const TicketStepper(currentStep: 1),
          ),
          const SizedBox(height: 10),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Info Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                         BoxShadow(color: Colors.grey.shade200, blurRadius: 5, offset: const Offset(0, 2))
                      ]
                    ),
                    child: Row(
                      children: [
                        // Date Box
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Tháng 12", style: GoogleFonts.josefinSans(fontSize: 10, color: Colors.grey)),
                              Text("27", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ANH TRAI \"SAY HI\" 2025 CONCERT",
                                style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text("Khu đô thị Vạn Phúc, TPHCM", style: GoogleFonts.josefinSans(fontSize: 14, color: Colors.grey)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  // 3. Seat Map (Using Poster as placeholder if no specific map asset, but name 'sodoghe' from context if available)
                  // Assuming "assets/images/poster_test.png" for now as placeholder
                  // 3. Seat Map
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/mapatsh.png",
                      width: double.infinity,
                      // height: 200, // Let's keep 200 or allow auto? Placeholder was 200. User wants real map. 200 might be small for a map.
                      // Let's use 200 and fit.contain or cover? Cover might crop important info. Map usually needs contain or just fit width. 
                      // If I use fitWidth, height adjusts. 
                      // Let's use fitWidth and no fixed height? Or fixed height 250?
                      // The placeholder had 200.
                      // Let's try fit: BoxFit.contain inside a Container with color? Or just Image.
                      // If I use Image.asset with width double.infinity and fit BoxFit.fitWidth, it will take needed height.
                      fit: BoxFit.fitWidth, 
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 4. Ticket List
                  _buildTicketRow(
                    "Hạng A", 
                    priceA, 
                    countA, 
                    Colors.green,
                    (val) => setState(() => countA = val)
                  ),
                   _buildTicketRow(
                    "Hạng B", 
                    priceB, 
                    countB, 
                    Colors.yellow,
                    (val) => setState(() => countB = val)
                  ),
                   _buildTicketRow(
                    "Hạng C", 
                    priceC, 
                    countC, 
                    Colors.blue,
                    (val) => setState(() => countC = val)
                  ),

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
               boxShadow: [
                 BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
               ]
             ),
             child: SafeArea( // Wrap in SafeArea
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Tạm tính", style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold)),
                       Text(formatCurrency(totalAmount), style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFFb11d39))),
                     ],
                   ),
                   const SizedBox(height: 16),
                   SizedBox(
                     width: double.infinity,
                     height: 50,
                     child: ElevatedButton(
                       onPressed: totalAmount > 0 
                        ? () {
                          List<String> parts = [];
                          if (countA > 0) parts.add("Hạng A x$countA");
                          if (countB > 0) parts.add("Hạng B x$countB");
                          if (countC > 0) parts.add("Hạng C x$countC");
                          String summary = parts.isEmpty ? "Hạng C x1" : parts.join(", ");

                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => PaymentInfoScreen(
                                totalAmount: totalAmount,
                                ticketSummary: summary,
                              )
                            )
                          );
                        } 
                        : null, // Disable if 0
                       style: ElevatedButton.styleFrom(
                         backgroundColor: const Color(0xFF013aad),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                       ),
                       child: Text("Tiếp tục", style: GoogleFonts.josefinSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                     ),
                   )
                 ],
               ),
             ),
          )
        ],
      ),
    );
  }

  // --- Widgets ---
  
  Widget _buildTicketRow(String name, int price, int count, Color color, Function(int) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
           Row(
             children: [
               Container(width: 4, height: 40, color: color, margin: const EdgeInsets.only(right: 12)),
                Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(name, style: GoogleFonts.josefinSans(fontSize: 17, fontWeight: FontWeight.w600)),
                     Text(formatCurrency(price), style: GoogleFonts.josefinSans(fontSize: 16, color: const Color(0xFF013aad), fontWeight: FontWeight.w600)),
                   ],
                 ),
               ),
               // Counters
               IconButton(
                 onPressed: count > 0 ? () => onChanged(count - 1) : null,
                 icon: Icon(Icons.remove, size: 20, color: count > 0 ? const Color(0xFF013aad) : Colors.grey.shade300),
                 style: IconButton.styleFrom(
                   shape: RoundedRectangleBorder(
                     side: BorderSide(color: count > 0 ? const Color(0xFF013aad) : Colors.grey.shade300), 
                     borderRadius: BorderRadius.circular(4)
                   )
                 ),
               ),
               Container(
                 width: 40,
                 height: 40,
                 alignment: Alignment.center,
                 color: Colors.grey.shade200,
                 child: Text(count.toString(), style: GoogleFonts.josefinSans(fontSize: 18, fontWeight: FontWeight.bold)),
               ),
                IconButton(
                 onPressed: () => onChanged(count + 1),
                 icon: const Icon(Icons.add, size: 20, color: Color(0xFF013aad)),
                  style: IconButton.styleFrom(
                   shape: RoundedRectangleBorder(side: BorderSide(color: const Color(0xFF013aad)), borderRadius: BorderRadius.circular(4))
                 ),
               ),
             ],
           ),
           const Divider(),
        ],
      )
    );
  }
}
