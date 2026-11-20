import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class HomeScreen extends StatelessWidget {
  final StudioConfig config;
  final Function(int) onNavigate;
  const HomeScreen({super.key, required this.config, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Modular Kitchen', 'subtitle': 'Italian Acrylic, Matte PU & Island', 'icon': Icons.kitchen, 'tab': 1},
      {'title': 'Luxury Wardrobes', 'subtitle': 'Walk-in Closets & Tinted Glass', 'icon': Icons.door_sliding, 'tab': 2},
      {'title': 'Living Room', 'subtitle': 'TV Consoles, Panelling & Sofas', 'icon': Icons.weekend, 'tab': 3},
      {'title': 'Turnkey Projects', 'subtitle': '3BHK, 4BHK & Luxury Villas', 'icon': Icons.photo_library, 'tab': 4},
    ];

    return Scaffold(
      appBar: StudioAppBar(config: config),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1C1912), Color(0xFF121215)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.champagneGold, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('BESPOKE LUXURY LIVING', style: TextStyle(color: AppTheme.champagneGold, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.8)),
                const SizedBox(height: 8),
                Text('Crafting Timeless Interiors for Modern Homes', style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 10),
                const Text('Turnkey interior architecture, precision modular kitchens & custom wardrobes.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 13, height: 1.5)),
                const SizedBox(height: 18),
                Row(
                  children: [
                    ElevatedButton(onPressed: () => onNavigate(7), child: const Text('Get Free Quote')),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(foregroundColor: AppTheme.champagneGold, side: const BorderSide(color: AppTheme.champagneGold), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                      onPressed: () => config.openWhatsApp(context),
                      child: const Text('WhatsApp'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text('Explore Collections', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          ...categories.map((cat) => GestureDetector(
                onTap: () => onNavigate(cat['tab'] as int),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppTheme.darkSurface, borderRadius: BorderRadius.circular(12)),
                        child: Icon(cat['icon'] as IconData, color: AppTheme.champagneGold),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cat['title'] as String, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(cat['subtitle'] as String, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 12)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: AppTheme.champagneGold, size: 16),
                    ],
                  ),
                ),
              )),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(foregroundColor: AppTheme.pureWhite, side: const BorderSide(color: AppTheme.goldBorder), padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () => onNavigate(5),
                  icon: const Icon(Icons.info_outline, color: AppTheme.champagneGold, size: 18),
                  label: const Text('About Us'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(foregroundColor: AppTheme.pureWhite, side: const BorderSide(color: AppTheme.goldBorder), padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () => onNavigate(6),
                  icon: const Icon(Icons.contact_phone_outlined, color: AppTheme.champagneGold, size: 18),
                  label: const Text('Contact Studio'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
