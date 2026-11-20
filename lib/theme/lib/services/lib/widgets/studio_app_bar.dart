import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class StudioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final StudioConfig config;
  final String? subtitle;
  const StudioAppBar({super.key, required this.config, this.subtitle});

  Future<void> _pickLogo(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      await config.saveLogoPath(file.path);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('UT HOME STUDIO logo updated!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 16,
      title: Row(
        children: [
          GestureDetector(
            onTap: () => _pickLogo(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppTheme.charcoalCard,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.champagneGold, width: 1.2),
              ),
              child: config.logoPath.isNotEmpty && File(config.logoPath).existsSync()
                  ? ClipRRect(borderRadius: BorderRadius.circular(9), child: Image.file(File(config.logoPath), fit: BoxFit.cover))
                  : const Center(child: Text('UT', style: TextStyle(color: AppTheme.champagneGold, fontWeight: FontWeight.bold, fontSize: 15))),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('UT HOME STUDIO', style: TextStyle(color: AppTheme.champagneGold, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 1.4)),
              Text(subtitle ?? 'LUXURY INTERIORS', style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 10, letterSpacing: 1.6)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(tooltip: 'Upload Logo', icon: const Icon(Icons.add_photo_alternate_outlined, size: 22), onPressed: () => _pickLogo(context)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4);
}
