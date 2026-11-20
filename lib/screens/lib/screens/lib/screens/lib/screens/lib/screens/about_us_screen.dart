import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class AboutUsScreen extends StatelessWidget {
  final StudioConfig config;
  final VoidCallback onGetQuote;
  const AboutUsScreen({super.key, required this.config, required this.onGetQuote});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('About UT HOME STUDIO', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.goldBorder)),
          child: const Text(
            'UT HOME STUDIO specializes in bespoke Modular Kitchens, Premium Wardrobes, Living Room Interiors, custom TV Units, and Complete Turnkey Home Design — blending timeless luxury aesthetics with precision factory craftsmanship.',
            style: TextStyle(color: AppTheme.softIvory, fontSize: 14, height: 1.6),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _statBox(config.yearsExperience.isEmpty ? 'Set in Contact' : config.yearsExperience, 'Our Experience')),
            const SizedBox(width: 12),
            Expanded(child: _statBox(config.projectsCompleted.isEmpty ? 'Set in Contact' : config.projectsCompleted, 'Delivered Homes')),
          ],
        ),
        const SizedBox(height: 20),
        Text('Why Choose UT Home Studio', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        _reasonTile('Precision Factory Finish', 'German edge-banding, BWP marine grade boards & premium hardware.'),
        _reasonTile('3D Visualization Before Execution', 'Photorealistic 3D views of every room before production starts.'),
        _reasonTile('Transparent Pricing & Timeline', 'Clear itemized quotation with dedicated site supervision.'),
        _reasonTile('End-to-End Turnkey Execution', 'From civil & false ceiling to modular furniture and final styling.'),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onGetQuote, child: const Text('Schedule a Studio Consultation')),
      ],
    );
  }

  Widget _statBox(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: AppTheme.champagneGold, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _reasonTile(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
      child: Row(
        children: [
          const Icon(Icons.verified, color: AppTheme.champagneGold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppTheme.pureWhite, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 12.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
