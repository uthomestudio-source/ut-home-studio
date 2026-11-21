import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/studio_storage.dart';
import 'screens/main_shell.dart';
import 'screens/erp_portal_screen.dart';

String? _startupError;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    _startupError = 'Firebase Error: $e';
  }
  final config = StudioConfig();
  try {
    await config.load();
  } catch (_) {}
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
            useMaterial3: true,
          ),
          home: _startupError != null
              ? Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(_startupError!, style: const TextStyle(color: Colors.red)),
                    ),
                  ),
                )
              : StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(body: Center(child: CircularProgressIndicator()));
                    }
                    if (!snapshot.hasData) {
                      return const ErpLoginScreen();
                    }
                    return Builder(
                      builder: (ctx) => Stack(
                        children: [
                          MainShell(config: config),
                          Positioned(
                            right: 16,
                            bottom: 84,
                            child: FloatingActionButton.extended(
                              heroTag: 'erp_btn',
                              onPressed: () => Navigator.push(
                                ctx,
                                MaterialPageRoute(builder: (_) => const SiteUpdatesSheet()),
                              ),
                              icon: const Icon(Icons.cloud_upload),
                              label: const Text('Site ERP'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
