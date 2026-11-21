import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/studio_storage.dart';
import 'screens/main_shell.dart';
import 'screens/erp_portal_screen.dart';

const FirebaseOptions _kFirebaseOptions = FirebaseOptions(
  apiKey: 'AIzaSyC8fVUoQMpIK4fYYYSVf8KIQ7J81C4AGqY',
  appId: '1:150587865934:android:57830a739cb3db6b7c3c1f',
  messagingSenderId: '150587865934',
  projectId: 'ut-home-erp',
  storageBucket: 'ut-home-erp.firebasestorage.app',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? startupError;
  try {
    await Firebase.initializeApp(options: _kFirebaseOptions);
  } catch (e) {
    startupError = 'Firebase initialization failed: $e';
  }

  final studioConfig = StudioConfig();
  try {
    await studioConfig.load();
  } catch (_) {}

  runApp(UtHomeStudioApp(config: studioConfig, startupError: startupError));
}

class UtHomeStudioApp extends StatelessWidget {
  final StudioConfig config;
  final String? startupError;

  const UtHomeStudioApp({
    super.key,
    required this.config,
    this.startupError,
  });

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
          home: startupError != null
              ? _StartupErrorView(message: startupError!)
              : _AuthGate(config: config),
        );
      },
    );
  }
}

class _AuthGate extends StatelessWidget {
  final StudioConfig config;

  const _AuthGate({required this.config});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return const ErpLoginScreen();
        }

        return Scaffold(
          body: MainShell(config: config),
          floatingActionButton: FloatingActionButton.extended(
            heroTag: 'erp_btn',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SiteUpdatesSheet()),
              );
            },
            icon: const Icon(Icons.cloud_upload),
            label: const Text('Site ERP'),
          ),
        );
      },
    );
  }
}

class _StartupErrorView extends StatelessWidget {
  final String message;

  const _StartupErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
