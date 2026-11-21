import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../services/cloudinary_service.dart';

class ErpLoginScreen extends StatefulWidget {
  const ErpLoginScreen({super.key});

  @override
  State<ErpLoginScreen> createState() => _ErpLoginScreenState();
}

class _ErpLoginScreenState extends State<ErpLoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.apartment, size: 70, color: Color(0xFF1E3A8A)),
              const SizedBox(height: 12),
              const Text('UT HOME ERP', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  child: _loading ? const CircularProgressIndicator() : const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SiteUpdatesSheet extends StatefulWidget {
  const SiteUpdatesSheet({super.key});

  @override
  State<SiteUpdatesSheet> createState() => _SiteUpdatesSheetState();
}

class _SiteUpdatesSheetState extends State<SiteUpdatesSheet> {
  final _siteCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  bool _uploading = false;

  Future<void> _uploadUpdate() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked == null) return;
    setState(() => _uploading = true);
    final url = await CloudinaryService.uploadPhoto(File(picked.path));
    if (url != null) {
      await FirebaseFirestore.instance.collection('site_updates').add({
        'siteName': _siteCtrl.text.trim().isEmpty ? 'Site Update' : _siteCtrl.text.trim(),
        'note': _noteCtrl.text.trim(),
        'photoUrl': url,
        'uploadedBy': FirebaseAuth.instance.currentUser?.email ?? 'Team',
        'createdAt': FieldValue.serverTimestamp(),
      });
      _siteCtrl.clear();
      _noteCtrl.clear();
    }
    if (mounted) setState(() => _uploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Site Photos & ERP Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(controller: _siteCtrl, decoration: const InputDecoration(labelText: 'Client / Site Name')),
                TextField(controller: _noteCtrl, decoration: const InputDecoration(labelText: 'Work / Expense Note')),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _uploading ? null : _uploadUpdate,
                  icon: const Icon(Icons.cloud_upload),
                  label: Text(_uploading ? 'Uploading...' : 'Upload Site Photo & Save'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('site_updates').orderBy('createdAt', descending: true).snapshots(),
              builder: (context, snap) {
                if (!snap.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snap.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final d = docs[i].data() as Map<String, dynamic>;
                    return ListTile(
                      leading: d['photoUrl'] != null ? Image.network(d['photoUrl'], width: 50, height: 50, fit: BoxFit.cover) : null,
                      title: Text(d['siteName'] ?? ''),
                      subtitle: Text('${d['note'] ?? ''}\n${d['uploadedBy'] ?? ''}'),
                      isThreeLine: true,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
