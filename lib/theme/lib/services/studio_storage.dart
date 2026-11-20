import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StudioConfig extends ChangeNotifier {
  String phone = '';
  String whatsapp = '';
  String email = '';
  String address = '';
  String mapsUrl = '';
  String logoPath = '';
  String yearsExperience = '';
  String projectsCompleted = '';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('studio_phone') ?? '';
    whatsapp = prefs.getString('studio_whatsapp') ?? '';
    email = prefs.getString('studio_email') ?? '';
    address = prefs.getString('studio_address') ?? '';
    mapsUrl = prefs.getString('studio_maps') ?? '';
    logoPath = prefs.getString('studio_logo_path') ?? '';
    yearsExperience = prefs.getString('studio_years') ?? '';
    projectsCompleted = prefs.getString('studio_projects') ?? '';
    notifyListeners();
  }

  Future<void> saveDetails({
    required String newPhone,
    required String newWhatsapp,
    required String newEmail,
    required String newAddress,
    required String newMapsUrl,
    String? newYears,
    String? newProjects,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    phone = newPhone.trim();
    whatsapp = newWhatsapp.trim();
    email = newEmail.trim();
    address = newAddress.trim();
    mapsUrl = newMapsUrl.trim();
    if (newYears != null) yearsExperience = newYears.trim();
    if (newProjects != null) projectsCompleted = newProjects.trim();

    await prefs.setString('studio_phone', phone);
    await prefs.setString('studio_whatsapp', whatsapp);
    await prefs.setString('studio_email', email);
    await prefs.setString('studio_address', address);
    await prefs.setString('studio_maps', mapsUrl);
    await prefs.setString('studio_years', yearsExperience);
    await prefs.setString('studio_projects', projectsCompleted);
    notifyListeners();
  }

  Future<void> saveLogoPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    logoPath = path;
    await prefs.setString('studio_logo_path', path);
    notifyListeners();
  }

  Future<void> openWhatsApp(BuildContext context, {String? customMessage}) async {
    if (whatsapp.isEmpty) {
      _showMissingAlert(context, 'WhatsApp Number');
      return;
    }
    final cleanNumber = whatsapp.replaceAll(RegExp(r'[^0-9]'), '');
    final text = Uri.encodeComponent(customMessage ?? 'Hello UT HOME STUDIO, I would like to enquire about interior design.');
    final uri = Uri.parse('https://wa.me/$cleanNumber?text=$text');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> makeCall(BuildContext context) async {
    if (phone.isEmpty) {
      _showMissingAlert(context, 'Phone Number');
      return;
    }
    await launchUrl(Uri(scheme: 'tel', path: phone));
  }

  Future<void> openMaps(BuildContext context) async {
    if (mapsUrl.isEmpty) {
      _showMissingAlert(context, 'Google Maps Link');
      return;
    }
    await launchUrl(Uri.parse(mapsUrl), mode: LaunchMode.externalApplication);
  }

  void _showMissingAlert(BuildContext context, String fieldName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1E1E24),
        content: Text('$fieldName not set yet. Go to Contact Us -> Edit Details to add it.'),
      ),
    );
  }
}
