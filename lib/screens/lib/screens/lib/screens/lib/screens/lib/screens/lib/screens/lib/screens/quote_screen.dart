import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class QuoteScreen extends StatefulWidget {
  final StudioConfig config;
  const QuoteScreen({super.key, required this.config});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  String _selectedService = 'Complete Home Interior Design';
  final List<String> _services = ['Modular Kitchen', 'Premium Wardrobes', 'Living Room Interiors', 'TV Units', 'Complete Home Interior Design'];

  void _submitEnquiry() {
    if (!_formKey.currentState!.validate()) return;
    final summary = 'New Quote Request - UT HOME STUDIO\nName: ${_nameCtrl.text.trim()}\nMobile: ${_mobileCtrl.text.trim()}\nService: $_selectedService\nMessage: ${_msgCtrl.text.trim()}';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppTheme.charcoalCard,
        title: const Text('Enquiry Ready', style: TextStyle(color: AppTheme.champagneGold)),
        content: const Text('Your quotation request has been prepared. Send it directly to UT HOME STUDIO on WhatsApp now?', style: TextStyle(color: AppTheme.softIvory)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close', style: TextStyle(color: AppTheme.mutedSilver))),
          ElevatedButton(onPressed: () { Navigator.pop(context); widget.config.openWhatsApp(context, customMessage: summary); }, child: const Text('Send via WhatsApp')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Get a Free Quote', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Fill in your project details and our senior interior designer will connect with you.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
          const SizedBox(height: 18),
          TextFormField(controller: _nameCtrl, style: const TextStyle(color: AppTheme.pureWhite), decoration: _inputDecoration('Customer Name', Icons.person_outline), validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null),
          const SizedBox(height: 14),
          TextFormField(controller: _mobileCtrl, keyboardType: TextInputType.phone, style: const TextStyle(color: AppTheme.pureWhite), decoration: _inputDecoration('Mobile Number', Icons.phone_android), validator: (v) => (v == null || v.trim().length < 8) ? 'Please enter a valid mobile number' : null),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: _selectedService,
            dropdownColor: AppTheme.charcoalCard,
            style: const TextStyle(color: AppTheme.pureWhite),
            decoration: _inputDecoration('Select Service', Icons.design_services_outlined),
            items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) { if (val != null) setState(() => _selectedService = val); },
          ),
          const SizedBox(height: 14),
          TextFormField(controller: _msgCtrl, maxLines: 4, style: const TextStyle(color: AppTheme.pureWhite), decoration: _inputDecoration('Message (Flat size, city, requirements...)', Icons.message_outlined)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _submitEnquiry, child: const Text('Submit Enquiry')),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppTheme.mutedSilver),
      prefixIcon: Icon(icon, color: AppTheme.champagneGold),
      filled: true,
      fillColor: AppTheme.charcoalCard,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.goldBorder)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppTheme.champagneGold, width: 1.5)),
    );
  }
}
