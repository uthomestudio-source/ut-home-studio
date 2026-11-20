import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class WardrobeScreen extends StatefulWidget {
  final StudioConfig config;
  final VoidCallback onGetQuote;
  const WardrobeScreen({super.key, required this.config, required this.onGetQuote});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  String _type = 'Sliding';
  final Map<String, List>> _wardrobes = {
    'Sliding': [
      {
        'title': 'Tinted Glass & Champagne Aluminum Sliding Wardrobe',
        'specs': 'Soft-close sliding tracks, motion sensor strip lights, velvet jewelry tray.',
        'image': 'https://images.unsplash.com/photo-1558997519-83ea9252edf8?auto=format&fit=crop&w=900&q=80',
      },
      {
        'title': 'Mirror & Matte Charcoal Sliding Suite',
        'specs': 'Floor-to-ceiling space-saving sliding shutters with internal drawers.',
        'image': 'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?auto=format&fit=crop&w=900&q=80',
      },
    ],
    'Hinged': [
      {
        'title': 'Fluted Veneer & Brass Handle Hinged Wardrobe',
        'specs': 'Full-opening 110° soft-close hinges with overhead loft storage.',
        'image': 'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=900&q=80',
      },
    ],
    'Walk-in': [
      {
        'title': 'Bespoke Boutique Walk-In Closet',
        'specs': 'Island dresser, open backlit shelving, leatherette organizers & glass doors.',
        'image': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?auto=format&fit=crop&w=900&q=80',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final list = _wardrobes[_type] ?? [];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Premium Wardrobe Gallery', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        Row(
          children: ['Sliding', 'Hinged', 'Walk-in'].map((t) {
            final active = _type == t;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: active ? AppTheme.champagneGold : AppTheme.charcoalCard,
                    foregroundColor: active ? AppTheme.obsidianBlack : AppTheme.pureWhite,
                  ),
                  onPressed: () => setState(() => _type = t),
                  child: Text(t),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        ...list.map((w) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppTheme.goldBorder)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(18)), child: Image.network(w['image']!, height: 210, width: double.infinity, fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$_type WARDROBE'.toUpperCase(), style: const TextStyle(color: AppTheme.champagneGold, fontSize: 11, letterSpacing: 1.2)),
                        const SizedBox(height: 4),
                        Text(w['title']!, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 17, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(w['specs']!, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
                        const SizedBox(height: 14),
                        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: widget.onGetQuote, child: const Text('Customize This Wardrobe'))),
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
