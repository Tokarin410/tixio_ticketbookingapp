import 'package:tixio/models/event_model.dart';
// Note: This data is temporary for Seeding purposes only.
// Once seeded, this file can be cleared again if strict separation is desired, 
// though keeping it as a fallback isn't a bad idea until the app is fully stable.

// --- 1. Define Organizers ---
final Organizer vieChannel = Organizer(
  name: "Vie Channel",
  logoAsset: "assets/images/Logo/Logo_VieChannel.png",
  description: "Nhà sản xuất các chương trình giải trí hàng đầu Việt Nam như Rap Việt, Siêu Trí Tuệ, Ca Sĩ Mặt Nạ...",
);

final Organizer yenSuaConcert = Organizer(
  name: "Yên Concert",
  logoAsset: "assets/images/Logo/btcyconcert.jpg",
  description: "Chuỗi đêm nhạc acoustic chữa lành tâm hồn, mang đến không gian âm nhạc nhẹ nhàng và sâu lắng.",
);

final Organizer garenaLienQuan = Organizer(
  name: "Garena Liên Quân Mobile",
  logoAsset: "assets/images/Logo/btcsport1.jpg",
  description: "Nhà phát hành tựa game MOBA số 1 Việt Nam - Liên Quân Mobile, tổ chức các giải đấu eSports quy mô lớn.",
);

final Organizer vbcBasketball = Organizer(
  name: "VBC - Vietnam Basketball Championship",
  logoAsset: "assets/images/Logo/btcsport2.jpg",
  description: "Giải vô địch bóng rổ chuyên nghiệp Việt Nam, nơi quy tụ những tài năng bóng rổ hàng đầu.",
);

final Organizer hbso = Organizer(
  name: "HBSO",
  logoAsset: "assets/images/Logo/btcnhacsong1.jpg",
  description: "Nhà hát Giao hưởng Nhạc Vũ Kịch Thành phố Hồ Chí Minh - Biểu tượng nghệ thuật hàn lâm.",
);

// --- 2. Define Ticket Tiers ---
// Common ticket tiers can be reused or defined uniquely per event if prices vary excessively.
// Here we define unique sets for variety.

// Set 1: High End Concert (Anh Trai Say Hi)
final List<TicketTier> tiersATSH = [
  TicketTier(name: "GA 1", price: 2000000, totalQuantity: 500, benefits: ["Khu vực đứng gần sân khấu", "Quà tặng lightstick"]),
  TicketTier(name: "GA 2", price: 1500000, totalQuantity: 1000, benefits: ["Khu vực đứng giữa"]),
  TicketTier(name: "VIP SEAT", price: 3500000, totalQuantity: 200, benefits: ["Ghế ngồi VIP", "Lối đi riêng", "Check-in ưu tiên"]),
];

// Set 2: Sport Final (DTDV)
final List<TicketTier> tiersSport = [
  TicketTier(name: "Hạng Nhất", price: 500000, totalQuantity: 2000, benefits: ["Ghế ngồi khán đài A", "Góc nhìn toàn cảnh"]),
  TicketTier(name: "Hạng Nhì", price: 300000, totalQuantity: 3000, benefits: ["Ghế ngồi khán đài B"]),
];

// --- 3. Define Events ---
List<Event> allEvents = [
  // 1. ANH TRAI "SAY HI"
  Event(
    id: "atsh_2025",
    title: 'ANH TRAI "SAY HI" 2025 CONCERT',
    dateTime: "19:00 - 23:00, 27/12/2025",
    dateOnly: "27/12/2025",
    location: "Sân vận động Quân Khu 7, TP. HCM",
    priceRange: "Từ 1.500.000đ",
    posterImage: "assets/images/Poster ngang/ATSH.png",
    description: "Đêm nhạc hội tụ dàn 'Anh Trai' hot nhất 2025 với những màn trình diễn bùng nổ, sân khấu hoành tráng và âm thanh ánh sáng đỉnh cao. Hứa hẹn mang đến trải nghiệm không thể quên cho người hâm mộ.",
    organizer: vieChannel,
    ticketTiers: tiersATSH,
    category: "nhacsong",
    seatMapImage: "assets/images/Map/mapatsh.png",
    bannerImage: "assets/images/Poster dọc/ATSH.jpg",
    collectionName: "nhacsong",
  ),

  // 2. Y-CONCERT
  Event(
    id: "y_concert_2025",
    title: "Y-CONCERT - MÌNH ĐOÀN VIÊN THÔI",
    dateTime: "18:00 - 22:00, 25/12/2025",
    dateOnly: "25/12/2025",
    location: "Nhà hát Hòa Bình, TP. HCM",
    priceRange: "Từ 800.000đ",
    posterImage: "assets/images/Poster ngang/Ycon.jpg",
    description: "Một đêm nhạc ấm cúng dịp Giáng Sinh, nơi những trái tim cô đơn tìm thấy sự đồng điệu. Cùng nhau chia sẻ những câu chuyện và giai điệu ngọt ngào.",
    organizer: yenSuaConcert,
    ticketTiers: [TicketTier(name: "Standard", price: 800000, totalQuantity: 800, benefits: ["Vị trí tự do"])],
    seatMapImage: "assets/images/Map/mapyconcert.png",
    category: "Nhạc sống",
    collectionName: "nhacsong",
  ),

  // 3. CHỊ ĐẸP ĐẠP GIÓ
  Event(
    id: "cddg_2025",
    title: "CHỊ ĐẸP ĐẠP GIÓ CONCERT 2025",
    dateTime: "19:30 - 23:00, 30/12/2025",
    dateOnly: "30/12/2025",
    location: "Trung tâm Hội nghị Quốc gia, Hà Nội",
    priceRange: "Từ 2.000.000đ",
    posterImage: "assets/images/Poster ngang/CDDG.jpg",
    description: "Sự trở lại của các 'Chị Đẹp' quyền lực với những tiết mục được đầu tư công phu. Đêm tôn vinh vẻ đẹp và tài năng của người phụ nữ hiện đại.",
    organizer: vieChannel,
    ticketTiers: tiersATSH, // Reusing similar tiers roughly
    seatMapImage: "assets/images/Map/mapchidep.png",
    category: "Nhạc sống",
    collectionName: "nhacsong",
  ),

  // 4. ANH TRAI VƯỢT NGÀN CHÔNG GAI
  Event(
    id: "atvncg_encore",
    title: "ANH TRAI VƯỢT NGÀN CHÔNG GAI ENCORE",
    dateTime: "20:00 - 00:00, 31/12/2025",
    dateOnly: "31/12/2025",
    location: "Phố đi bộ Nguyễn Huệ, TP. HCM",
    priceRange: "Miễn phí / Khu VIP",
    posterImage: "assets/images/Poster ngang/ATVNCG.jpg",
    description: "Đêm diễn Encore đếm ngược chào đón năm mới 2026. Bùng cháy cùng các anh tài và hàng ngàn khán giả tại phố đi bộ.",
    organizer: vieChannel,
    ticketTiers: [TicketTier(name: "Fanzone VIP", price: 500000, totalQuantity: 500, benefits: ["Khu vực gần sân khấu", "Lightstick"])],
    seatMapImage: "assets/images/Map/mapatvncg.jpg",
    category: "Nhạc sống",
    collectionName: "nhacsong",
  ),

  // 5. GENFEST
  Event(
    id: "genfest_2025",
    title: "GENFEST - CỔNG ÂM NHẠC ĐA GIÁC QUAN",
    dateTime: "09:00 - 23:00, 15/12/2025",
    dateOnly: "15/12/2025",
    location: "The Global City, TP. Thủ Đức",
    priceRange: "Từ 999.000đ",
    posterImage: "assets/images/Poster ngang/genfest.jpg",
    description: "Lễ hội âm nhạc đa giác quan dành cho Gen Z. Không chỉ là âm nhạc, mà còn là nghệ thuật, thời trang và công nghệ.",
    organizer: vieChannel, // Placeholder
    ticketTiers: [TicketTier(name: "Early Bird", price: 999000, totalQuantity: 1000, benefits: ["Vào cửa sớm"])],
    category: "Nhạc sống",
    collectionName: "nhacsong",
  ),

  // 6. SOL 8
  Event(
    id: "sol8_concert",
    title: "SOL 8 - TRẦN THÀNH CONCERT",
    dateTime: "19:00, 20/01/2026",
    dateOnly: "20/01/2026",
    location: "Sân khấu Lan Anh, TP. HCM",
    priceRange: "Từ 500.000đ",
    posterImage: "assets/images/Poster ngang/sol8.jpg",
    description: "Show diễn cá nhân đầy cảm xúc của nghệ sĩ Trần Thành.",
    organizer: vieChannel, // Placeholder
    ticketTiers: tiersSport, // Reusing low cost
    category: "Nhạc sống",
    collectionName: "nhacsong",
  ),

  // 7. Nhạc Sống Hoàng Hải - Uyên Linh (Specific ID for Category Section)
  Event(
    id: "nhacsong_hh_ul",
    title: "[BẾN THÀNH] Đêm nhạc Hoàng Hải - Uyên Linh",
    dateTime: "20:00, 27/12/2025",
    dateOnly: "27/12/2025",
    location: "Nhà hát Bến Thành, TP. HCM",
    priceRange: "800.000đ - 2.000.000đ",
    posterImage: "assets/images/Nhạc sống/nhacsong1.jpg",
    description: "Sự kết hợp tuyệt vời giữa 'Bố Gấu' Hoàng Hải và Diva Uyên Linh. Một đêm nhạc trữ tình và đẳng cấp.",
    organizer: yenSuaConcert,
    ticketTiers: tiersSport,
    category: "Nhạc sống",
    collectionName: "nhacsong",
  ),

  // 8. Thể thao DTQV (Specific ID for Category Section)
  Event(
    id: "sport_dtdv_2025",
    title: "CHUNG KẾT ĐTDV MÙA ĐÔNG 2025",
    dateTime: "14:00, 27/12/2025",
    dateOnly: "27/12/2025",
    location: "Nhà thi đấu Quân Khu 7",
    priceRange: "300.000đ - 500.000đ",
    posterImage: "assets/images/Thể thao/sport1.jpg", // Corrected path assumption
    description: "Trận chung kết nảy lửa của Đấu Trường Danh Vọng Mùa Đông 2025. Ai sẽ là nhà vua mới của Liên Quân Mobile Việt Nam?",
    organizer: garenaLienQuan,
    ticketTiers: tiersSport,
    seatMapImage: "assets/images/Map/mapsport1.png",
    category: "sports",
    collectionName: "sports",
  ),

  // 9. Thể thao VBC (Specific ID for Category Section)
  Event(
    id: "sport_vbc_2025",
    title: "VBC 2025 - SAIGON HEAT vs HANOI BUFFALOES",
    dateTime: "17:00, 28/12/2025",
    dateOnly: "28/12/2025",
    location: "Nhà thi đấu CIS, TP. HCM",
    priceRange: "200.000đ - 1.500.000đ",
    posterImage: "assets/images/Thể thao/sport1.jpg", // Placeholder reusing sport image
    description: "Trận đại chiến bóng rổ giữa hai miền Nam Bắc. Saigon Heat tiếp đón Hanoi Buffaloes trên sân nhà.",
    organizer: vbcBasketball,
    ticketTiers: tiersSport,
    seatMapImage: "assets/images/Map/mapsport2.png",
    category: "Thể thao",
    collectionName: "sports",
  ),
];
