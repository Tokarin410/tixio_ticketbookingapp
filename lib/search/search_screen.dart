import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/buy_ticket/thongtinsukien.dart';
import 'package:tixio/search/widgets/filter_bottom_sheet.dart';
import 'package:tixio/data/events_data.dart';
import 'package:tixio/models/event_model.dart';
import 'package:tixio/services/firestore_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); 
  bool _isFocused = false; 
  String _searchQuery = "";
  
  // Mock Data for Trending
  final List<String> trendingKeywords = [
    "anh trai say hi",
    "chị đẹp đạp gió",
    "soobin",
    "concert 2025"
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose(); 
    super.dispose();
  }

  // Filter State
  String? _selectedCategory;
  String? _selectedTime;
  DateTime? _startDate;
  DateTime? _endDate;

  void _showFilterModal() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );

    if (result != null) {
      setState(() {
        _selectedCategory = result['category'];
        _selectedTime = result['time'];
        _startDate = result['startDate'];
        _endDate = result['endDate'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF013aad),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Tìm kiếm",
          style: GoogleFonts.josefinSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Event>>(
        stream: FirestoreService().getCombinedEventsStream(),
        builder: (context, snapshot) {
          final allEventsList = snapshot.data ?? allEvents; 

          // Filter logic
          List<Event> displayEvents = allEventsList.where((event) {
            bool matchesQuery = _searchQuery.isEmpty || event.title.toLowerCase().contains(_searchQuery.toLowerCase());
            
            // Category Filter
            bool matchesCategory = true;
            if (_selectedCategory != null && _selectedCategory!.isNotEmpty && _selectedCategory != "Tất cả") {
               // Map display name to key if needed, or use raw if matched
               String key = _selectedCategory!;
               if (key == "Nhạc sống") key = "nhacsong";
               if (key == "Thể thao") key = "sports";
               
               if (key == "Khác") {
                  matchesCategory = event.category != "nhacsong" && event.category != "sports";
               } else {
                  matchesCategory = event.category == key;
               }
            }

            // Time Filter
            bool matchesTime = true;
            DateTime? eventDate;
            
            // Check if ANY time filter is active
            bool isTimeFilterActive = _startDate != null || (_selectedTime != null && _selectedTime!.isNotEmpty && _selectedTime != "Tất cả các ngày");

            // Safe Date Parsing
            try {
               // Format 1: "12 tháng 12, 2025" (Existing Data)
               if (event.dateOnly.contains("tháng")) {
                   final parts = event.dateOnly.split(' ');
                   if (parts.length >= 4) { 
                     int day = int.parse(parts[0]);
                     int month = int.parse(parts[2].replaceAll(',', ''));
                     int year = int.parse(parts[3]);
                     eventDate = DateTime(year, month, day);
                   }
               } 
               // Format 2: "dd/MM/yyyy" (Common)
               else if (event.dateOnly.contains("/")) {
                   final parts = event.dateOnly.split('/');
                   if (parts.length == 3) {
                      int day = int.parse(parts[0]);
                      int month = int.parse(parts[1]);
                      int year = int.parse(parts[2]);
                      eventDate = DateTime(year, month, day);
                   }
               }
               // Format 3: "yyyy-MM-dd" (ISO)
               else if (event.dateOnly.contains("-")) {
                   eventDate = DateTime.parse(event.dateOnly);
               }
            } catch (e) {
               // Parsing failed
               eventDate = null;
            }

            // Apply Logic
            if (isTimeFilterActive) {
               if (eventDate == null) {
                  // Filter is active but date is invalid -> Hide Event
                  matchesTime = false;
               } else {
                  // Filter is active and date is valid -> Check Match
                   if (_startDate != null) {
                      // Range or Single Date Filter
                      if (_endDate != null) {
                         // Range Check [Start, End]
                         // Normalize to start of day for accurate comparison
                         DateTime start = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
                         
                         // End of the day for endDate
                         DateTime end = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59);
                         
                         matchesTime = eventDate.isAfter(start.subtract(const Duration(milliseconds: 1))) && 
                                       eventDate.isBefore(end);
                      } else {
                         // Single Exact Date Match
                         matchesTime = eventDate.year == _startDate!.year && 
                                       eventDate.month == _startDate!.month && 
                                       eventDate.day == _startDate!.day;
                      }
                   } else if (_selectedTime != null) {
                      final now = DateTime.now();
                      if (_selectedTime == "Hôm nay") {
                         matchesTime = eventDate.year == now.year && 
                                       eventDate.month == now.month && 
                                       eventDate.day == now.day;
                      } else if (_selectedTime == "Tháng này") {
                         matchesTime = eventDate.year == now.year && 
                                       eventDate.month == now.month;
                      }
                   }
               }
            }
            // else: matching is true (default) because no time filter is active

            return matchesQuery && matchesCategory && matchesTime;
          }).toList();

          return Column(
            children: [
              // Search Bar Area
              Container(
                 padding: const EdgeInsets.all(16),
                 child: Column(
                   children: [
                     // Search Input
                     TextField(
                       controller: _searchController,
                       focusNode: _focusNode, 
                       onChanged: (value) {
                         setState(() {
                           _searchQuery = value;
                         });
                       },
                       decoration: InputDecoration(
                         hintText: "Nhập từ khoá",
                         hintStyle: GoogleFonts.josefinSans(color: Colors.grey),
                         prefixIcon: null, 
                         suffixIcon: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: (_searchQuery.isNotEmpty || _isFocused) ? Colors.black : Colors.transparent, // Dynamic Color
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.search, 
                              color: (_searchQuery.isNotEmpty || _isFocused) ? Colors.white : Colors.grey, // Dynamic Icon Color
                              size: 20
                            ),
                         ),
                         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), 
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15), 
                           borderSide: const BorderSide(color: Colors.grey),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15), 
                           borderSide: const BorderSide(color: Colors.grey),
                         ),
                          focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(15), 
                           borderSide: const BorderSide(color: Color(0xFF013aad)),
                         ),
                       ),
                     ),
                     const SizedBox(height: 12),
                     // Filter chip
                     Align(
                       alignment: Alignment.centerLeft,
                       child: GestureDetector(
                         onTap: _showFilterModal,
                         child: Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                           decoration: BoxDecoration(
                             color: const Color(0xFFA51C30), // Red color
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               const Icon(Icons.filter_list, color: Colors.white, size: 16),
                               const SizedBox(width: 4),
                               Text(
                                 "Bộ lọc",
                                 style: GoogleFonts.josefinSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                 ),
                               ),
                                const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Trending (Only show if NOT searching)
                      if (_searchQuery.isEmpty)
                        _buildTrending(),
                      
                      // 2. Results / Suggestions
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          _searchQuery.isEmpty ? "Gợi ý dành cho bạn" : "Kết quả tìm kiếm",
                          style: GoogleFonts.josefinSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      if (displayEvents.isEmpty)
                         const Padding(
                           padding: EdgeInsets.all(16), 
                           child: Center(child: Text("Không tìm thấy kết quả nào."))
                         )
                      else
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.15,
                          ),
                          itemCount: displayEvents.length,
                          itemBuilder: (context, index) {
                            final event = displayEvents[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigate
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinSuKienScreen(event: event)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16), 
                                        image: DecorationImage(
                                          image: AssetImage(event.posterImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Title
                                  SizedBox(
                                    height: 32,
                                    child: Text(
                                      event.title,
                                      style: GoogleFonts.josefinSans(
                                        color: const Color(0xFF013aad), 
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12, 
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Date
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 12, color: Color(0xFFA51C30)),
                                      const SizedBox(width: 4),
                                      Text(
                                        event.dateOnly,
                                        style: GoogleFonts.josefinSans(
                                          color: const Color(0xFFA51C30),
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                       const SizedBox(height: 20),
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

  Widget _buildTrending() {
     // Implement clickable trending items to auto-search
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Row(
              children: [
                const Icon(Icons.local_fire_department, color: Color(0xFFA51C30), size: 20),
                const SizedBox(width: 8),
                Text(
                 "Đang thịnh hành",
                 style: GoogleFonts.josefinSans(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                   color: Colors.grey[700],
                 ),
               ),
              ],
            ),
           const SizedBox(height: 10),
           ...trendingKeywords.map((keyword) => GestureDetector(
             onTap: () {
               // Auto populate search
               setState(() {
                 _searchController.text = keyword;
                 _searchQuery = keyword;
               });
             },
             child: Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: Row(
                 children: [
                   const Icon(Icons.circle, size: 6, color: Color(0xFFA51C30)),
                    const SizedBox(width: 12),
                   Text(
                     keyword,
                     style: GoogleFonts.josefinSans(
                       color: const Color(0xFFA51C30),
                       fontSize: 16,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                 ],
               ),
             ),
           )),
           const SizedBox(height: 20), // Spacer before suggestions
         ],
       ),
     );
  }
}
