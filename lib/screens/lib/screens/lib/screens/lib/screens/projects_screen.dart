import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class ProjectsScreen extends StatefulWidget {
  final StudioConfig config;
  const ProjectsScreen({super.key, required this.config});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Before & After Transformation', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 6),
        const Text('Slide the golden bar to compare raw site vs finished luxury interior.', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 12.5)),
        const SizedBox(height: 12),
        Container(
          height: 230,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), border: Border.all(color: AppTheme.champagneGold, width: 1.2)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(17),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                return Stack(
                  children: [
                    Image.network('https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=900&q=80', width: width, height: 230, fit: BoxFit.cover),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: _sliderValue,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.darken),
                          child: Image.network('https://images.unsplash.com/photo-1503387762-592deb58ef4e?auto=format&fit=crop&w=900&q=80', width: width, height: 230, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(left: width * _sliderValue - 1.5, top: 0, bottom: 0, child: Container(width: 3, color: AppTheme.champagneGold)),
                    const Positioned(left: 12, top: 12, child: Chip(label: Text('BEFORE', style: TextStyle(fontSize: 10)))),
                    const Positioned(right: 12, top: 12, child: Chip(backgroundColor: AppTheme.champagneGold, label: Text('AFTER', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)))),
                  ],
                );
              },
            ),
          ),
        ),
        Slider(value: _sliderValue, activeColor: AppTheme.champagneGold, inactiveColor: AppTheme.darkSurface, onChanged: (v) => setState(() => _sliderValue = v)),
        const SizedBox(height: 16),
        Text('Project Video Walkthroughs', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.goldBorder)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: Image.network('https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=900&q=80', height: 180, width: double.infinity, fit: BoxFit.cover)),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.champagneGold,
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow, color: AppTheme.obsidianBlack, size: 32),
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add your studio project video link here.'))),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('4BHK Luxury Residence Walkthrough', style: TextStyle(color: AppTheme.pureWhite, fontWeight: FontWeight.bold, fontSize: 15)),
                    SizedBox(height: 4),
                    Text('Complete Turnkey Modular Kitchen, Walk-In Wardrobe & Living Room', style: TextStyle(color: AppTheme.mutedSilver, fontSize: 12.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text('Completed Photo Gallery', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=600&q=80',
            'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?auto=format&fit=crop&w=600&q=80',
            'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?auto=format&fit=crop&w=600&q=80',
            'https://images.unsplash.com/photo-1556911220-bff31c812dba?auto=format&fit=crop&w=600&q=80',
          ].map((url) => ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.network(url, fit: BoxFit.cover))).toList(),
        ),
      ],
    );
  }
}
