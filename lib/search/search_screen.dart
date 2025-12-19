666666import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketcon/homepage/sections/for_you_section.dart';
import 'package:ticketcon/search/widgets/filter_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Added FocusNode
  bool _isTyping = false;
  bool _isFocused = false; // Added state
  
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
    _focusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow full height
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
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
      body: Column(
        children: [
          // Search Bar Area
          Container(
             padding: const EdgeInsets.all(16),
             child: Column(
               children: [
                 // Search Input
                 TextField(
                   controller: _searchController,
                   focusNode: _focusNode, // Assign FocusNode
                   onChanged: (value) {
                     setState(() {
                       _isTyping = value.isNotEmpty;
                     });
                   },
                   decoration: InputDecoration(
                     hintText: "Nhập từ khoá",
                     hintStyle: GoogleFonts.josefinSans(color: Colors.grey),
                     prefixIcon: null, 
                     suffixIcon: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (_isTyping || _isFocused) ? Colors.black : Colors.transparent, // Dynamic Color
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search, 
                          color: (_isTyping || _isFocused) ? Colors.white : Colors.grey, // Dynamic Icon Color
                          size: 20
                        ),
                     ),
                     contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Widened
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15), // Radius 15
                       borderSide: const BorderSide(color: Colors.grey),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15), // Radius 15
                       borderSide: const BorderSide(color: Colors.grey),
                     ),
                      focusedBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(15), // Radius 15
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
              child: _isTyping ? _buildTrending() : _buildSuggestions(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
           child: Text(
             "Gợi ý dành cho bạn",
             style: GoogleFonts.josefinSans(
               fontSize: 18,
               fontWeight: FontWeight.bold,
             ),
           ),
         ),
         const SizedBox(height: 10),
         // Reuse existing component for consistency
         // We might need to adjust it slightly if it has its own padding/headers we don't want,
         // but based on view_file, ForYouSection has its own header "Dành cho bạn".
         // Let's assume we want to mock the content. 
         // Actually, ForYouSection replicates the grid content. 
         // Since ForYouSection includes the header "Dành cho bạn", 
         // I will suppress my own header above to avoid duplication or just use ForYouSection directly.
         // Wait, ForYouSection has a big "Dành cho bạn" header. 
         // The design shows "Gợi ý dành cho bạn".
         // I'll just use ForYouSection but wrap it effectively.
         // Or even better, just copy the logic for cleaner UI control matching the specific Search design.
         // The user wants the Search screen exactly as image.
         
         const Padding(
           padding: EdgeInsets.symmetric(horizontal: 0), 
           child: ForYouSection(showHeader: false), // Header hidden to avoid duplication
         ),
      ],
    );
  }

  Widget _buildTrending() {
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
           ...trendingKeywords.map((keyword) => Padding(
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
           )),
         ],
       ),
     );
  }
}
