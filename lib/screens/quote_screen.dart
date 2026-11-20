import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class QuoteScreen extends StatefulWidget {
  final StudioConfig config;
  const QuoteScreen({super.key, required this.config});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  String _selectedService = 'Full Home Turnkey Interior';

  final List<String> _services = [
    'Full Home Turnkey Interior',
    'Modular Kitchen',
    'Luxury Wardrobe & Closet',
    'Living Room & TV Unit',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudioAppBar(config: widget.config, subtitle: 'GET FREE ESTIMATE'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Request Design Consultation', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Share your requirements for a personalized quote.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
          const SizedBox(height: 20),
          TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Your Full Name', border: OutlineInputBorder())),
          const SizedBox(height: 14),
          TextField(controller: _phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone / WhatsApp Number', border: OutlineInputBorder())),
          const SizedBox(height: 14),
          TextField(controller: _cityCtrl, decoration: const InputDecoration(labelText: 'City / Project Location', border: OutlineInputBorder())),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: _selectedService,
            dropdownColor: AppTheme.charcoalCard,
            decoration: const InputDecoration(labelText: 'Requirement Type', border: OutlineInputBorder()),
            items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) => setState(() => _selectedService = val!),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: () {
              final msg = 'Hello UT HOME STUDIO, I want a consultation.\nName: ${_nameCtrl.text}\nPhone: ${_phoneCtrl.text}\nCity: ${_cityCtrl.text}\nService: $_selectedService';
              widget.config.openWhatsApp(context, customMessage: msg);
            },
            icon: const Icon(Icons.send),
            label: const Text('Send Enquiry on WhatsApp'),
          ),
        ],
      ),
    );
  }
}
