import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import '../widgets/studio_app_bar.dart';

class ProjectsScreen extends StatelessWidget {
  final StudioConfig config;
  final Function(int) onNavigate;
  const ProjectsScreen({super.key, required this.config, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final projects = [
      {'name': '4BHK Penthouse Residence', 'scope': 'Turnkey Interior, Italian Kitchen & Walk-in Closets', 'area': '4,200 Sq.Ft'},
      {'name': 'Modern Luxury Villa', 'scope': 'Double-Height Living, Veneer Panelling & Lighting', 'area': '6,500 Sq.Ft'},
      {'name': '3BHK Contemporary Apartment', 'scope': 'Modular Kitchen, Sliding Wardrobes & TV Console', 'area': '2,400 Sq.Ft'},
      {'name': 'Duplex Sky Lounge & Home', 'scope': 'Bespoke Furniture, Bar Unit & Master Suite', 'area': '3,800 Sq.Ft'},
    ];

    return Scaffold(
      appBar: StudioAppBar(config: config, subtitle: 'PORTFOLIO & PROJECTS'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Signature Projects', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Crafted luxury spaces delivered with precision.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
          const SizedBox(height: 18),
          ...projects.map((p) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(p['name']!, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 16, fontWeight: FontWeight.bold))),
                        Text(p['area']!, style: const TextStyle(color: AppTheme.champagneGold, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(p['scope']!, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: () => onNavigate(7), child: const Text('Request Similar Design')),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
