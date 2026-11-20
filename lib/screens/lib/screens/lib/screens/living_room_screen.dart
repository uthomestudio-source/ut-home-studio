import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class LivingRoomScreen extends StatelessWidget {
  final StudioConfig config;
  final VoidCallback onGetQuote;
  const LivingRoomScreen({super.key, required this.config, required this.onGetQuote});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'tag': 'MODERN LIVING ROOM DESIGNS',
        'title': 'Grand Double-Height & Contemporary Lounge',
        'desc': 'False ceiling cove lighting, Italian marble accents, and bespoke sofa layouts.',
        'image': 'https://images.unsplash.com/photo-1600210491892-03d54c0aaf87?auto=format&fit=crop&w=900&q=80',
      },
      {
        'tag': 'TV UNITS',
        'title': 'Floating Marble & Brass Backlit TV Console',
        'desc': 'Concealed wire management, fluted drawers, and warm ambient backlighting.',
        'image': 'https://images.unsplash.com/photo-1593696140826-c58b021acf8b?auto=format&fit=crop&w=900&q=80',
      },
      {
        'tag': 'WALL PANELS',
        'title': 'Charcoal WPC Louvers & Gold Inlay Wall Panelling',
        'desc': 'Acoustic wood slats, PU panels, and metallic trim feature walls.',
        'image': 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=900&q=80',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Living Room, TV Units & Wall Panels', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 14),
        ...sections.map((s) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppTheme.goldBorder)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(18)), child: Image.network(s['image']!, height: 195, width: double.infinity, fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s['tag']!, style: const TextStyle(color: AppTheme.champagneGold, fontSize: 11, letterSpacing: 1.2)),
                        const SizedBox(height: 4),
                        Text(s['title']!, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 17, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(s['desc']!, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
                        const SizedBox(height: 12),
                        ElevatedButton(onPressed: onGetQuote, child: const Text('Book Design Consultation')),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
