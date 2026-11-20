import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  final StudioConfig config;
  const ContactUsScreen({super.key, required this.config});

  void _openEditDialog(BuildContext context) {
    final phoneCtrl = TextEditingController(text: config.phone);
    final waCtrl = TextEditingController(text: config.whatsapp);
    final emailCtrl = TextEditingController(text: config.email);
    final addrCtrl = TextEditingController(text: config.address);
    final mapCtrl = TextEditingController(text: config.mapsUrl);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.charcoalCard,
        title: const Text('Edit Studio Details', style: TextStyle(color: AppTheme.champagneGold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone Number')),
              TextField(controller: waCtrl, decoration: const InputDecoration(labelText: 'WhatsApp Number (with 91)')),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email Address')),
              TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: 'Studio Address')),
              TextField(controller: mapCtrl, decoration: const InputDecoration(labelText: 'Google Maps Link')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              await config.saveDetails(
                newPhone: phoneCtrl.text,
                newWhatsapp: waCtrl.text,
                newEmail: emailCtrl.text,
                newAddress: addrCtrl.text,
                newMapsUrl: mapCtrl.text,
              );
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudioAppBar(config: config, subtitle: 'CONTACT & STUDIO'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Contact Us', style: Theme.of(context).textTheme.headlineMedium),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: AppTheme.champagneGold, side: const BorderSide(color: AppTheme.champagneGold)),
                onPressed: () => _openEditDialog(context),
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Edit Details'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _infoTile(Icons.phone, 'Phone', config.phone.isEmpty ? 'Tap Edit Details to add phone' : config.phone, () => config.makeCall(context)),
          _infoTile(Icons.chat, 'WhatsApp', config.whatsapp.isEmpty ? 'Tap Edit Details to add WhatsApp' : config.whatsapp, () => config.openWhatsApp(context)),
          _infoTile(Icons.location_on, 'Studio Address', config.address.isEmpty ? 'Tap Edit Details to add address' : config.address, () => config.openMaps(context)),
          _infoTile(Icons.email, 'Email', config.email.isEmpty ? 'Tap Edit Details to add email' : config.email, () {}),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.champagneGold),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
