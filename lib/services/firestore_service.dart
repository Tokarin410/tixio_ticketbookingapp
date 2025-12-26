import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tixio/models/event_model.dart';
import 'package:tixio/data/events_data.dart';
import 'package:tixio/models/ticket_model.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _eventsRef => _db.collection('events');

  // Fetch all events
  Future<List<Event>> getEvents() async {
    try {
      QuerySnapshot snapshot = await _eventsRef.get();
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['collectionName'] = 'events'; // Explicitly set source
        return Event.fromMap(data);
      }).toList();
    } catch (e) {
      print("Error fetching events: $e");
      return [];
    }
  }

  // Combined Stream for Global Usage (All Collections)
  Stream<List<Event>> getCombinedEventsStream() {
    return Rx.combineLatest3(
      getEventsFromCollection('events'), 
      getEventsFromCollection('nhacsong'), 
      getEventsFromCollection('sports'), 
      (List<Event> a, List<Event> b, List<Event> c) {
        // Merge and Deduplicate
        Map<String, Event> uniqueEvents = {};
        
        // Add generic events first (lower priority)
        for (var e in a) {
          uniqueEvents[e.id] = e;
        }
        
        // Overwrite with specific collections (higher priority)
        for (var e in b) {
          uniqueEvents[e.id] = e;
        }
        for (var e in c) {
          uniqueEvents[e.id] = e;
        }
        
        return uniqueEvents.values.toList();
      }
    );
  }

  // Legacy stream (kept for ref, but we will use combined)
  Stream<List<Event>> getEventsStream() {
    return _eventsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Fetch events from specific collection (e.g., 'nhacsong', 'sports')
  Stream<List<Event>> getEventsFromCollection(String collectionPath) {
    return _db.collection(collectionPath).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        try {
          var data = doc.data() as Map<String, dynamic>;
          data['collectionName'] = collectionPath; // Inject source collection
          return Event.fromMap(data);
        } catch (e) {
          print("Error parsing event ${doc.id} in $collectionPath: $e");
          return null;
        }
      }).where((e) => e != null).cast<Event>().toList();
    });
  }

  // Get stream for a single event
  Stream<Event> getEventStream(String id, String category, {String? collectionName}) {
    String collection = 'events';
    
    // Priority: Explicit collectionName -> Category Inference
    if (collectionName != null && collectionName.isNotEmpty) {
       collection = collectionName;
    } else {
      String catLower = category.toLowerCase();
      
      if (catLower.contains('nhạc sống') || catLower.contains('nhacsong')) {
        collection = 'nhacsong';
      } else if (catLower.contains('thể thao') || catLower.contains('sports') || catLower.contains('sport')) {
        collection = 'sports';
      }
    }
    
    return _db.collection(collection).doc(id).snapshots().map((doc) {
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        data['collectionName'] = collection; // Ensure consistency
        return Event.fromMap(data);
      } else {
        throw Exception("Event not found");
      }
    });
  }

  // Seed data (Run this once)
  Future<void> seedEvents() async {
    print("Seeding events to Firestore...");
    try {
      // Check if data already exists to avoid duplicates/overwrite safety
      for (var event in allEvents) {
        String collection = 'events';
        String catLower = event.category.toLowerCase();
        
        if (catLower.contains('nhạc sống') || catLower.contains('nhacsong')) {
          collection = 'nhacsong';
        } else if (catLower.contains('thể thao') || catLower.contains('sports') || catLower.contains('sport')) {
          collection = 'sports';
        }

        final docRef = _db.collection(collection).doc(event.id);
        final docSnapshot = await docRef.get();
        
        if (!docSnapshot.exists) {
          // Add collectionName tracking to the seeding document
          var eventData = event.toMap();
          eventData['collectionName'] = collection; // Ensure consistency in DB
          await docRef.set(eventData);
          print("Seeded event: ${event.title} into $collection");
        } else {
           print("Skipped existing event: ${event.title} in $collection");
        }
        
        // CLEANUP: Delete from legacy 'events' collection if it belongs elsewhere
        if (collection != 'events') {
           final legacyDocRef = _db.collection('events').doc(event.id);
           final legacySnap = await legacyDocRef.get();
           if (legacySnap.exists) {
              await legacyDocRef.delete();
              print("Deleted legacy duplicate: ${event.title} from 'events'");
           }
        }
      }
      print("Seeding complete!");
    } catch (e) {
      print("Error seeding events: $e");
    }
  }
  // Save a new ticket
  Future<void> saveTicket(Ticket ticket) async {
    try {
      await _db.collection('tickets').doc(ticket.id).set(ticket.toMap());
      print("Ticket saved: ${ticket.id}");
    } catch (e) {
      print("Error saving ticket: $e");
      throw e;
    }
  }

  // Get tickets for a user
  Stream<List<Ticket>> getUserTickets(String userId) {
    return _db
        .collection('tickets')
        .where('userId', isEqualTo: userId)
        .orderBy('purchaseDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Ticket.fromMap(doc.data())).toList();
    });
  }

  // Users Collection
  CollectionReference get _usersRef => _db.collection('users');

  // Create or Update User Profile
  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _usersRef.doc(uid).set(data, SetOptions(merge: true));
    } catch (e) {
      print("Error updating user profile: $e");
      throw e;
    }
  }

  // Get User Profile Stream
  Stream<DocumentSnapshot> getUserProfileStream(String uid) {
    return _usersRef.doc(uid).snapshots();
  }

  // Get User Profile Future
  Future<DocumentSnapshot> getUserProfile(String uid) {
    return _usersRef.doc(uid).get();
  }

  // Update Event Ticket Quantity Transaction
  // quantities: Map<TierName, QuantityPurchased>
  Future<void> updateEventTicketQuantity(String eventId, String category, Map<String, int> quantities) async {
    String collection = 'events';
    String catLower = category.toLowerCase();
    
    if (catLower.contains('nhạc sống') || catLower.contains('nhacsong')) {
      collection = 'nhacsong';
    } else if (catLower.contains('thể thao') || catLower.contains('sports') || catLower.contains('sport')) {
      collection = 'sports';
    }

    DocumentReference eventRef = _db.collection(collection).doc(eventId);

    return _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(eventRef);

      if (!snapshot.exists) {
        throw Exception("Event does not exist!");
      }

      Event event = Event.fromMap(snapshot.data() as Map<String, dynamic>);
      List<TicketTier> updatedTiers = [];
      bool changed = false;

      for (var tier in event.ticketTiers) {
        if (quantities.containsKey(tier.name)) {
          int quantityToBuy = quantities[tier.name]!;
          if (tier.available < quantityToBuy) {
            throw Exception("Not enough tickets for ${tier.name}. Available: ${tier.available}");
          } else {
             updatedTiers.add(TicketTier(
               name: tier.name,
               price: tier.price,
               totalQuantity: tier.totalQuantity,
               soldQuantity: tier.soldQuantity + quantityToBuy,
               benefits: tier.benefits
             ));
             changed = true;
          }
        } else {
          updatedTiers.add(tier);
        }
      }

      if (changed) {
        transaction.update(eventRef, {
        });
      }
    });
  }

  // Add a new event
  Future<void> addEvent(Event event) async {
    String collection = 'events';
    String catLower = event.category.toLowerCase();
    
    if (catLower.contains('nhạc sống') || catLower.contains('nhacsong')) {
      collection = 'nhacsong';
    } else if (catLower.contains('thể thao') || catLower.contains('sports') || catLower.contains('sport')) {
      collection = 'sports';
    }

    try {
      // Use set instead of add to control the ID if it's already generated, or use doc() if ID is empty/auto
      if (event.id.isNotEmpty) {
         await _db.collection(collection).doc(event.id).set(event.toMap());
      } else {
         DocumentReference docRef = _db.collection(collection).doc();
         // If ID was empty, we might want to update the event object or save with the generated ID
         // But Event is immutable. Assuming user provides a slug/ID or we generate one before calling this.
         // Let's assume we use the provided ID.
         await docRef.set(event.toMap());
      }
      print("Event added to $collection: ${event.title}");
    } catch (e) {
      print("Error adding event: $e");
      throw e;
    }
  }

  // Migration Tool: Update legacy events with missing fields
  Future<void> migrateLegacyEvents() async {
     List<String> collections = ['nhacsong', 'sports', 'events'];
     
     for (String col in collections) {
       var snapshot = await _db.collection(col).get();
       for (var doc in snapshot.docs) {
         Map<String, dynamic> data = doc.data();
         List<dynamic> tiers = data['ticketTiers'] ?? [];
         bool needsUpdate = false;
         
         List<Map<String, dynamic>> updatedTiers = [];

         for (var tier in tiers) {
            Map<String, dynamic> tMap = tier as Map<String, dynamic>;
            if (!tMap.containsKey('totalQuantity') || !tMap.containsKey('soldQuantity')) {
               needsUpdate = true;
               // Default values for migration
               tMap['totalQuantity'] = tMap['totalQuantity'] ?? tMap['capacity'] ?? 1000; 
               tMap['soldQuantity'] = tMap['soldQuantity'] ?? 0;
            }
            updatedTiers.add(tMap);
         }

         if (needsUpdate) {
            await _db.collection(col).doc(doc.id).update({
              'ticketTiers': updatedTiers
            });
            print("Migrated event: ${doc.id} in $col");
         }
       }
     }
  }
}
