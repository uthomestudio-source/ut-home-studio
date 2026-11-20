import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class ModularKitchenScreen extends StatelessWidget {
  final StudioConfig config;
  final Function(int) onNavigate;
  const ModularKitchenScreen({super.key, required this.config, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final kitchens = [
      {'title': 'Italian Acrylic Island Kitchen', 'desc': 'Handleless high-gloss shutters, quartz countertop, soft-close German hardware.', 'tag': 'ISLAND LAYOUT'},
      {'title': 'Matte PU L-Shaped Kitchen', 'desc': 'Anti-fingerprint matte lacquer finish with built-in tall pantry & under-cabinet LED.', 'tag': 'L-SHAPED'},
      {'title': 'Parallel Luxury Chef Kitchen', 'desc': 'Dual-counter ergonomic workflow with marine BWP plywood & quartz backsplash.', 'tag': 'PARALLEL'},
      {'title': 'U-Shaped Veneer & Glass Kitchen', 'desc': 'Warm walnut wood grain paired with fluted tinted glass wall cabinets.', 'tag': 'U-SHAPED'},
    ];

    return Scaffold(
      appBar: StudioAppBar(config: config, subtitle: 'MODULAR KITCHENS'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Bespoke Modular Kitchens', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Engineered with BWP marine ply, Hettich/Blum hardware & Italian finishes.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
          const SizedBox(height: 18),
          ...kitchens.map((item) => Container(
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
                        ElevatedButton(onPressed: () => onNavigate(7), child: const Text('Get Kitchen Quote')),
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
