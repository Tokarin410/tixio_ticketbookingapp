import 'package:flutter/material.dart';

class MonthFilter extends StatefulWidget {
  const MonthFilter({super.key});

  @override
  State<MonthFilter> createState() => _MonthFilterState();
}

class _MonthFilterState extends State<MonthFilter> {
  int _selectedIndex = 0; // 0: This month, 1: Next month

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              _buildFilterButton("Tháng này", 0),
              const SizedBox(width: 16),
              _buildFilterButton("Tháng sau", 1),
            ],
          ),
        ),
        // Filtered content would go here
        
        // Just showing some example items
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                   BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 8,
                      offset: const Offset(0, 4)
                   )
                ]
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                      children: [
                          Expanded(child: Container(color: Colors.grey[300])), // Placeholder image
                          Container(
                              padding: const EdgeInsets.all(12),
                              color: Colors.white,
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Text("Event ${_selectedIndex == 0 ? 'This Month' : 'Next Month'} - Item ${index + 1}", 
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                      const SizedBox(height: 4),
                                      const Text("📅 27/12/2025  📍 TP. HCM", style: TextStyle(color: Colors.grey, fontSize: 12))
                                  ]
                              )
                          )
                      ]
                  )
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildFilterButton(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? const Color(0xFF4A68F0) : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
           Container(
            height: 3,
            width: 40,
            color: isSelected ? const Color(0xFF4A68F0) : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
