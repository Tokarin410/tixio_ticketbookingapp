import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String id;
  final String userId;
  final String eventId;
  final String eventTitle;
  final String eventDate;
  final String eventLocation;
  final String ticketClass; // e.g. "VIP x2"
  final double totalAmount;
  final DateTime purchaseDate;
  final String status; // "Sắp diễn ra", "Đã kết thúc", "Đã hủy"
  final String posterImage;

  Ticket({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    required this.ticketClass,
    required this.totalAmount,
    required this.purchaseDate,
    required this.status,
    required this.posterImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'eventTitle': eventTitle,
      'eventDate': eventDate,
      'eventLocation': eventLocation,
      'ticketClass': ticketClass,
      'totalAmount': totalAmount,
      'purchaseDate': Timestamp.fromDate(purchaseDate),
      'status': status,
      'posterImage': posterImage,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      eventId: map['eventId'] ?? '',
      eventTitle: map['eventTitle'] ?? '',
      eventDate: map['eventDate'] ?? '',
      eventLocation: map['eventLocation'] ?? '',
      ticketClass: map['ticketClass'] ?? '',
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      purchaseDate: (map['purchaseDate'] as Timestamp).toDate(),
      status: map['status'] ?? 'Sắp diễn ra',
      posterImage: map['posterImage'] ?? 'assets/images/ticket_banner_1.jpg',
    );
  }
}
