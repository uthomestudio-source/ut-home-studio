import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  final StudioConfig config;
  final Function(int) onNavigate;
  const AboutUsScreen({super.key, required this.config, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudioAppBar(config: config, subtitle: 'ABOUT THE STUDIO'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('UT HOME STUDIO', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 8),
          const Text(
            'UT HOME STUDIO is a premier luxury interior design and turnkey execution studio specializing in bespoke modular kitchens, architectural wardrobes, and timeless living spaces.',
            style: TextStyle(color: AppTheme.mutedSilver, fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _statCard(config.yearsExperience.isEmpty ? '10+' : config.yearsExperience, 'Years Experience')),
              const SizedBox(width: 12),
              Expanded(child: _statCard(config.projectsCompleted.isEmpty ? '250+' : config.projectsCompleted, 'Luxury Homes')),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Our Design Philosophy', style: TextStyle(color: AppTheme.champagneGold, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• 3D Photorealistic Visualization before execution\n• Factory-finished precision with German hardware\n• Transparent turnkey pricing & on-time handover', style: TextStyle(color: AppTheme.softIvory, fontSize: 13, height: 1.6)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => onNavigate(6), child: const Text('Connect With Our Designers')),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: AppTheme.champagneGold, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 12)),
        ],
      ),
    );
  }
}
