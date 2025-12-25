import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tixio/models/event_model.dart';
import 'package:tixio/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _titleController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceRangeController = TextEditingController();
  final _posterImageController = TextEditingController(text: "assets/images/ticket_banner_1.jpg"); // Default fallback
  final _descriptionController = TextEditingController();
  final _organizerNameController = TextEditingController(text: "Vie Channel");
  
  String _selectedCategory = "Nhạc sống";
  final List<String> _categories = ["Nhạc sống", "Thể thao"];
  final List<TicketTier> _ticketTiers = [];

  // Ticket Tier Controllers (Temp)
  final _tierNameController = TextEditingController();
  final _tierPriceController = TextEditingController();
  final _tierQuantityController = TextEditingController();
  final _tierBenefitsController = TextEditingController();

  bool _isLoading = false;

  void _addTicketTier() {
    if (_tierNameController.text.isEmpty || _tierPriceController.text.isEmpty || _tierQuantityController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vui lòng điền đủ thông tin vé")));
        return;
    }

    setState(() {
      _ticketTiers.add(TicketTier(
        name: _tierNameController.text,
        price: double.tryParse(_tierPriceController.text.replaceAll(',', '')) ?? 0,
        totalQuantity: int.tryParse(_tierQuantityController.text) ?? 100,
        soldQuantity: 0,
        benefits: _tierBenefitsController.text.split(',').map((e) => e.trim()).toList(),
      ));
      
      // Clear inputs
      _tierNameController.clear();
      _tierPriceController.clear();
      _tierQuantityController.clear();
      _tierBenefitsController.clear();
    });
  }

  void _saveEvent() async {
    if (!_formKey.currentState!.validate()) return;
    if (_ticketTiers.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vui lòng thêm ít nhất một loại vé")));
       return;
    }

    setState(() => _isLoading = true);

    try {
      final uuid = const Uuid();
      String eventId = uuid.v4(); // Generate unique ID

      Event newEvent = Event(
        id: eventId,
        title: _titleController.text,
        dateTime: _dateTimeController.text,
        dateOnly: _dateTimeController.text.split(',').last.trim(), // Rough parsing
        location: _locationController.text,
        priceRange: _priceRangeController.text,
        posterImage: _posterImageController.text,
        description: _descriptionController.text,
        ticketTiers: _ticketTiers,
        category: _selectedCategory,
        organizer: Organizer(
          name: _organizerNameController.text,
          logoAsset: "assets/images/Logo/Logo_VieChannel.png", // Hardcoded for now
          description: "Organized by ${_organizerNameController.text}",
        ),
      );

      await FirestoreService().addEvent(newEvent);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Thêm sự kiện thành công!")));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lỗi: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin - Thêm Sự Kiện", style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF013aad),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_sync),
            tooltip: "Cập nhật dữ liệu cũ",
            onPressed: () async {
               bool confirm = await showDialog(
                 context: context, 
                 builder: (_) => AlertDialog(
                   title: const Text("Cập nhật dữ liệu cũ?"),
                   content: const Text("Hành động này sẽ thêm trường 'totalQuantity' và 'soldQuantity' cho các sự kiện cũ chưa có."),
                   actions: [
                     TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Hủy")),
                     TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Đồng ý")),
                   ],
                 )
               ) ?? false;

               if (confirm) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đang cập nhật...")));
                 await FirestoreService().migrateLegacyEvents();
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã cập nhật xong!")));
               }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Thông tin chung"),
              _buildTextField(_titleController, "Tên sự kiện"),
              _buildTextField(_dateTimeController, "Ngày giờ (VD: 19:00, 25/12/2025)"),
              _buildTextField(_locationController, "Địa điểm"),
              _buildTextField(_priceRangeController, "Mức giá (VD: Từ 500k)"),
              _buildTextField(_posterImageController, "Link ảnh / Asset Path"),
              _buildTextField(_descriptionController, "Mô tả", maxLines: 3),
              const SizedBox(height: 10),
              
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: "Danh mục", border: OutlineInputBorder()),
                items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedCategory = v!),
              ),
              const SizedBox(height: 10),
              _buildTextField(_organizerNameController, "Tên BTC"),
              
              const Divider(height: 40),
              _buildSectionTitle("Các loại vé"),
              
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    _buildTextField(_tierNameController, "Tên loại vé (VD: VIP)", isRequired: false),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_tierPriceController, "Giá (VNĐ)", isRequired: false, isNumber: true)),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTextField(_tierQuantityController, "Số lượng", isRequired: false, isNumber: true)),
                      ],
                    ),
                    _buildTextField(_tierBenefitsController, "Quyền lợi (cách nhau bởi dấu phẩy)", isRequired: false),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _addTicketTier,
                      icon: const Icon(Icons.add),
                      label: const Text("Thêm loại vé"),
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              if (_ticketTiers.isNotEmpty)
                ..._ticketTiers.map((t) => ListTile(
                   title: Text("${t.name} - ${t.price}đ"),
                   subtitle: Text("SL: ${t.totalQuantity} - ${t.benefits.join(', ')}"),
                   leading: const Icon(Icons.confirmation_number),
                   trailing: IconButton(
                     icon: const Icon(Icons.delete, color: Colors.red),
                     onPressed: () => setState(() => _ticketTiers.remove(t)),
                   ),
                )),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF013aad),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("LƯU SỰ KIỆN", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 10),
      child: Text(title, style: GoogleFonts.josefinSans(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF013aad))),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isRequired = true, bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) return "Vui lòng nhập $label";
          return null;
        } : null,
      ),
    );
  }
}
