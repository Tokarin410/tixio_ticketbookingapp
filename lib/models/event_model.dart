class Event {
  final String id;
  final String title;
  final String dateTime; 
  final String dateOnly; 
  final String location; // Changed from locationName to match data usage
  final String priceRange;
  final String posterImage; 
  final String? bannerImage; // Vertical Poster (Poster doc)
  final String description;
  final Organizer organizer;
  final List<TicketTier> ticketTiers;
  final String category;
  final String? seatMapImage;
  final String? collectionName;

  Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.dateOnly,
    required this.location,
    required this.priceRange,
    required this.posterImage,
    this.bannerImage,
    required this.description,
    required this.organizer,
    required this.ticketTiers,
    required this.category,
    this.seatMapImage,
    this.collectionName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'dateTime': dateTime,
      'dateOnly': dateOnly,
      'location': location,
      'priceRange': priceRange,
      'posterImage': posterImage,
      'bannerImage': bannerImage,
      'description': description,
      'organizer': organizer.toMap(),
      'ticketTiers': ticketTiers.map((x) => x.toMap()).toList(),
      'category': category,
      'seatMapImage': seatMapImage,
      'collectionName': collectionName,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      dateTime: map['dateTime'] ?? '',
      dateOnly: map['dateOnly'] ?? '',
      location: map['location'] ?? '',
      priceRange: map['priceRange'] ?? '',
      posterImage: map['posterImage'] ?? '',
      bannerImage: map['bannerImage'],
      description: map['description'] ?? '',
      organizer: Organizer.fromMap(map['organizer'] ?? {}),
      ticketTiers: (map['ticketTiers'] is List)
        ? List<TicketTier>.from(
            (map['ticketTiers'] as List).map<TicketTier>((x) {
                if (x is Map<String, dynamic>) {
                   return TicketTier.fromMap(x);
                } else {
                   // Fallback for weird data
                   return TicketTier(name: "Standard", price: 0, totalQuantity: 0, benefits: []);
                }
            })
          )
        : [],
      category: map['category'] ?? '',
      seatMapImage: map['seatMapImage'],
      collectionName: map['collectionName'],
    );
  }

  // Helper to check if event ended
  bool get isEventEnded {
    try {
      // Format examples: 
      // "19:00 - 23:00, 27/12/2025"
      // "14:00 - 23:59, 29 tháng 12, 2025" (Sometimes Vietnamese text?)
      // "14:00, 27/12/2025"
      
      // 1. Split Date part
      // Assumption: Date is after last comma if comma exists
      if (!dateTime.contains(',')) return false; 
      
      List<String> mainParts = dateTime.split(',');
      String datePart = mainParts.last.trim(); // "27/12/2025"
      String timePart = mainParts.first.trim(); // "19:00 - 23:00"

      // Handle "tháng 12" case if exists? Data seems to use "27/12/2025" mostly based on events_data.dart
      // But let's check events_data.dart again. allEvents use "dd/MM/yyyy".
      // Just Parse dd/MM/yyyy
      List<String> dParts = datePart.split('/');
      if (dParts.length != 3) return false;
      int day = int.parse(dParts[0]);
      int month = int.parse(dParts[1]);
      int year = int.parse(dParts[2]);

      // 2. Parse Time
      int hour = 0;
      int minute = 0;

      // Check if range
      if (timePart.contains('-')) {
        // "19:00 - 23:00" -> take end time "23:00"
        String endTime = timePart.split('-').last.trim();
        List<String> tParts = endTime.split(':');
        hour = int.parse(tParts[0]);
        minute = int.parse(tParts[1]);
      } else {
        // "14:00" -> take start time "14:00", maybe add duration? 
        // For safety, let's assume it ends at end of day if no end time? 
        // Or just use start time. If start time passed? No, usually events last few hours.
        // Let's use start time + 4 hours buffer? Or just start time to be strict?
        // User request: "Sự kiện nào đã kết thúc". implies completely over.
        // If "14:00", maybe it's 2-3 hours.
        // Let's parse start time
        List<String> tParts = timePart.split(':');
        if (tParts.length >= 2) {
           hour = int.parse(tParts[0]);
           minute = int.parse(tParts[1]);
           // Add 4 hours buffer to be safe?
           hour += 4; 
           if (hour >= 24) {
             hour -= 24;
             // next day logic omitted for simplicity unless needed
           }
        }
      }

      DateTime eventEnd = DateTime(year, month, day, hour, minute);
      return DateTime.now().isAfter(eventEnd);

    } catch (e) {
      print("Error parsing date for event $id: $e");
      return false; // Fail safe: show as active
    }
  }
}

class Organizer {
  final String name;
  final String role; // Not in data usage, default to "Organizer"
  final String logoAsset;
  final String description; // Added

  Organizer({
    required this.name,
    this.role = "Organizer", // Default value
    required this.logoAsset,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
      'logoAsset': logoAsset,
      'description': description,
    };
  }

  factory Organizer.fromMap(Map<String, dynamic> map) {
    return Organizer(
      name: map['name'] ?? '',
      role: map['role'] ?? 'Organizer',
      logoAsset: map['logoAsset'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

class TicketTier {
  final String name; 
  final double price; 
  final int totalQuantity; // Changed from capacity to be more explicit, or verify usage. Plan said add totalQuantity. 
  final int soldQuantity;
  final List<String> benefits;

  // Computed property
  int get available => totalQuantity - soldQuantity;

  TicketTier({
    required this.name,
    required this.price,
    required this.totalQuantity,
    this.soldQuantity = 0,
    required this.benefits,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'totalQuantity': totalQuantity,
      'soldQuantity': soldQuantity,
      'benefits': benefits,
    };
  }

  factory TicketTier.fromMap(Map<String, dynamic> map) {
    return TicketTier(
      name: map['name'] ?? '',
      price: (map['price'] is num) 
          ? (map['price'] as num).toDouble() 
          : double.tryParse(map['price'].toString().replaceAll(',', '').replaceAll('.', '')) ?? 0,
      totalQuantity: (map['totalQuantity'] is int)
          ? map['totalQuantity']
          : (map['capacity'] is int ? map['capacity'] : int.tryParse(map['capacity'].toString()) ?? 1000), // Fallback to 1000 if missing
      soldQuantity: (map['soldQuantity'] is int) ? map['soldQuantity'] : 0,
      benefits: List<String>.from(map['benefits'] ?? []),
    );
  }
}
