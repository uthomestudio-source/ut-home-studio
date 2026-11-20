import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class LivingRoomScreen extends StatelessWidget {
  final StudioConfig config;
  final Function(int) onNavigate;
  const LivingRoomScreen({super.key, required this.config, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final designs = [
      {'title': 'Italian Marble & Fluted TV Console', 'desc': 'Book-matched marble backdrop with floating PU console & concealed wiring.', 'tag': 'TV FEATURE WALL'},
      {'title': 'Acoustic Wood Slat & Brass Panelling', 'desc': 'Double-height wall panelling with warm cove lighting & custom upholstery.', 'tag': 'WALL PANELLING'},
      {'title': 'Bespoke Lounge & Partition Design', 'desc': 'CNC PVD gold metal partition separating formal living and dining spaces.', 'tag': 'LIVING & DINING'},
    ];

    return Scaffold(
      appBar: StudioAppBar(config: config, subtitle: 'LIVING ROOM INTERIORS'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Signature Living Spaces', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Statement TV walls, PVD gold partitions & custom furniture.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
          const SizedBox(height: 18),
          ...designs.map((item) => Container(
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
                        ElevatedButton(onPressed: () => onNavigate(7), child: const Text('Get Living Quote')),
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
