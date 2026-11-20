import 'package:flutter/material.dart';
import 'services/studio_storage.dart';
import 'theme/app_theme.dart';
import 'screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = StudioConfig();
  await config.load();
  runApp(UtHomeStudioApp(config: config));
}

class UtHomeStudioApp extends StatelessWidget {
  final StudioConfig config;
  const UtHomeStudioApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: config,
      builder: (context, _) {
        return MaterialApp(
          title: 'UT HOME STUDIO',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkLuxuryTheme,
          home: MainShell(config: config),
        );
      },
    );
  }
}
