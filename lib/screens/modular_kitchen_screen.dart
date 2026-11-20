import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class ModularKitchenScreen extends StatefulWidget {
  final StudioConfig config;
  final VoidCallback onGetQuote;
  const ModularKitchenScreen({super.key, required this.config, required this.onGetQuote});

  @override
  State<ModularKitchenScreen> createState() => _ModularKitchenScreenState();
}

class _ModularKitchenScreenState extends State<ModularKitchenScreen> {
  String _selectedCategory = 'All';
  final List> _kitchens = [
    {
      'title': 'Obsidian & Brass Island Kitchen',
      'category': 'Island Kitchen',
      'finish': 'Matte PU Lacquer & Quartz Countertop',
      'hardware': 'Soft-Close Tandem Drawers & Built-in Pantry',
      'image': 'https://images.unsplash.com/photo-1556911220-bff31c812dba?auto=format&fit=crop&w=900&q=80',
    },
    {
      'title': 'Champagne Acrylic L-Shape Kitchen',
      'category': 'L-Shape',
      'finish': 'High-Gloss German Acrylic & Fluted Glass',
      'hardware': 'Corner Carousel & Profile LED Lighting',
      'image': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?auto=format&fit=crop&w=900&q=80',
    },
    {
      'title': 'Parallel Luxury Chef Kitchen',
      'category': 'Parallel',
      'finish': 'BWP Marine Ply + Anti-Fingerprint Laminate',
      'hardware': 'Tall Appliance Unit & Under-Cabinet Sensors',
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=900&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Island Kitchen', 'L-Shape', 'Parallel'];
    final filtered = _selectedCategory == 'All' ? _kitchens : _kitchens.where((k) => k['category'] == _selectedCategory).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Modular Kitchen Collections', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              final isSelected = _selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  selectedColor: AppTheme.champagneGold,
                  backgroundColor: AppTheme.charcoalCard,
                  labelStyle: TextStyle(color: isSelected ? AppTheme.obsidianBlack : AppTheme.pureWhite, fontWeight: FontWeight.w600),
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        ...filtered.map((item) => Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppTheme.goldBorder)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(18)), child: Image.network(item['image']!, height: 200, width: double.infinity, fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['category']!.toUpperCase(), style: const TextStyle(color: AppTheme.champagneGold, fontSize: 11, letterSpacing: 1.2)),
                        const SizedBox(height: 4),
                        Text(item['title']!, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Finish: ${item['finish']}', style: const TextStyle(color: AppTheme.softIvory, fontSize: 13)),
                        Text('Details: ${item['hardware']}', style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 13)),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(child: ElevatedButton(onPressed: widget.onGetQuote, child: const Text('Enquire This Design'))),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () => widget.config.openWhatsApp(context, customMessage: 'Hi UT HOME STUDIO, I liked "${item['title']}" Modular Kitchen.'),
                              icon: const Icon(Icons.chat, color: Color(0xFF25D366)),
                            ),
                          ],
                        ),
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
