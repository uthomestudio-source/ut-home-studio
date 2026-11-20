import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class WardrobeScreen extends StatelessWidget {
  final StudioConfig config;
  final Function(int) onNavigate;
  const WardrobeScreen({super.key, required this.config, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final wardrobes = [
      {'title': 'Fluted Tinted Glass Walk-In Closet', 'desc': 'Aluminium bronze profile shutters with sensor-activated warm profile lighting.', 'tag': 'WALK-IN CLOSET'},
      {'title': 'Floor-to-Ceiling Sliding Wardrobe', 'desc': 'Space-saving soft-close sliding doors in matte PU & leatherette finish.', 'tag': 'SLIDING SERIES'},
      {'title': 'Hinged Veneer & Brass Inlay Wardrobe', 'desc': 'Natural oak veneer panels accented with brushed champagne brass strips.', 'tag': 'HINGED LUXURY'},
    ];

    return Scaffold(
      appBar: StudioAppBar(config: config, subtitle: 'LUXURY WARDROBES'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Architectural Wardrobes', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Custom internal organizers, sensor LEDs & Italian glass shutters.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
          const SizedBox(height: 18),
          ...wardrobes.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.darkSurface, borderRadius: BorderRadius.circular(6)),
                      child: Text(item['tag']!, style: const TextStyle(color: AppTheme.champagneGold, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                    const SizedBox(height: 10),
                    Text(item['title']!, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(item['desc']!, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 13, height: 1.4)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () => onNavigate(7), child: const Text('Get Wardrobe Quote')),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(foregroundColor: AppTheme.champagneGold, side: const BorderSide(color: AppTheme.champagneGold)),
                          onPressed: () => config.openWhatsApp(context, customMessage: 'Hello UT HOME STUDIO, I want details for ${item['title']}.'),
                          child: const Text('WhatsApp'),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
