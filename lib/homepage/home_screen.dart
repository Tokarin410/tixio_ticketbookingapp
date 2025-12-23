import 'package:flutter/material.dart';
import 'package:tixio/homepage/sections/category_section.dart';
import 'package:tixio/homepage/sections/for_you_section.dart';
import 'package:tixio/homepage/sections/month_filter.dart';
import 'package:tixio/homepage/sections/special_events.dart';
import 'package:tixio/homepage/sections/trending_events.dart';
import 'package:tixio/taskbar_and_navbot/navigation_bottom.dart';
import 'package:tixio/taskbar_and_navbot/taskbar.dart';
import 'package:tixio/widgets/tixio_logo.dart';
import 'package:tixio/search/search_screen.dart';
import 'package:tixio/account/account_screen.dart';
import 'package:tixio/vecuatoi/myticket.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const Function(BuildContext) navigateFrom = NavigationBottom.navigateFrom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Solid White Background (covers the whole screen, ensuring bottom corners are white)
        Container(
          color: Colors.white,
        ),
        // Blue Header Background (only at the top)
        Container(
          height: 300, 
          color: const Color(0xFF013aad),
        ),
        // Main Content Layer
        Scaffold(
          backgroundColor: Colors.transparent, 
          drawer: const Taskbar(), // Add Side Menu (Taskbar)
          appBar: (_currentIndex == 2 || _currentIndex == 1)
              ? null 
              : AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 30), // Increased menu icon size slightly
                onPressed: () {
                   Scaffold.of(context).openDrawer();
                },
              ),
            ),
            title: ColorFiltered(
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              child: const TixioLogo(size: 150), 
            ),
            centerTitle: true,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.0), // Thinner border
                ),
                child: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white, size: 16), // Smaller icon
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const SearchScreen())
                    );
                  },
                  constraints: const BoxConstraints(minWidth: 28, minHeight: 28), // Smaller constraints
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          body: (_currentIndex == 2 || _currentIndex == 1)
            ? _buildBody()
            : Container(
             margin: const EdgeInsets.only(top: 10), // Spacing from AppBar
             decoration: const BoxDecoration(
               color: Colors.white,
             ),
             child: _buildBody(),
          ),
          bottomNavigationBar: NavigationBottom(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Ensure scrolling is always possible
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 100), // Add bottom padding to ensure last items are visible/scrollable above nav bar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TrendingEvents(),
              SizedBox(height: 20),
              SpecialEvents(),
              SizedBox(height: 20),
              ForYouSection(),
              SizedBox(height: 20),
              CategorySection(title: "Nhạc sống"),
              SizedBox(height: 20),
              CategorySection(title: "Thể thao"),
              SizedBox(height: 20),
              MonthFilter(),
              SizedBox(height: 100), // Extra space at bottom
            ],
          ),
        );
      case 1:
        return const MyTicketScreen();
      case 2:
        return const AccountScreen();
      default:
        return const SizedBox();
    }
  }
}
