import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';

class ContactUsScreen extends StatefulWidget {
  final StudioConfig config;
  const ContactUsScreen({super.key, required this.config});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool _isEditing = false;
  late TextEditingController _phoneCtrl, _waCtrl, _emailCtrl, _addressCtrl, _mapsCtrl, _yearsCtrl, _projectsCtrl;

  @override
  void initState() {
    super.initState();
    _phoneCtrl = TextEditingController(text: widget.config.phone);
    _waCtrl = TextEditingController(text: widget.config.whatsapp);
    _emailCtrl = TextEditingController(text: widget.config.email);
    _addressCtrl = TextEditingController(text: widget.config.address);
    _mapsCtrl = TextEditingController(text: widget.config.mapsUrl);
    _yearsCtrl = TextEditingController(text: widget.config.yearsExperience);
    _projectsCtrl = TextEditingController(text: widget.config.projectsCompleted);
  }

  Future<void> _save() async {
    await widget.config.saveDetails(
      newPhone: _phoneCtrl.text,
      newWhatsapp: _waCtrl.text,
      newEmail: _emailCtrl.text,
      newAddress: _addressCtrl.text,
      newMapsUrl: _mapsCtrl.text,
      newYears: _yearsCtrl.text,
      newProjects: _projectsCtrl.text,
    );
    setState(() => _isEditing = false);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('UT HOME STUDIO contact details saved!')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Contact UT Home Studio', style: Theme.of(context).textTheme.headlineMedium),
            TextButton.icon(
              onPressed: () => _isEditing ? _save() : setState(() => _isEditing = true),
              icon: Icon(_isEditing ? Icons.check : Icons.edit, color: AppTheme.champagneGold),
              label: Text(_isEditing ? 'Save' : 'Edit Details', style: const TextStyle(color: AppTheme.champagneGold, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_isEditing) ...[
          _editField(_phoneCtrl, 'Phone Number (e.g. +91 98XXXXXXXX)', Icons.phone),
          _editField(_waCtrl, 'WhatsApp Number (with country code)', Icons.chat),
          _editField(_emailCtrl, 'Studio Email Address', Icons.email),
          _editField(_addressCtrl, 'Studio Physical Address', Icons.location_on, maxLines: 2),
          _editField(_mapsCtrl, 'Google Maps Location URL', Icons.map),
          _editField(_yearsCtrl, 'Years of Experience (Optional)', Icons.workspace_premium),
          _editField(_projectsCtrl, 'Completed Projects Count (Optional)', Icons.apartment),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _save, child: const Text('Save Studio Information')),
        ] else ...[
          _infoCard(Icons.phone, 'Phone Number', widget.config.phone.isEmpty ? '[Tap Edit Details to add Phone Number]' : widget.config.phone),
          _infoCard(Icons.chat, 'WhatsApp Number', widget.config.whatsapp.isEmpty ? '[Tap Edit Details to add WhatsApp Number]' : widget.config.whatsapp),
          _infoCard(Icons.email, 'Email Address', widget.config.email.isEmpty ? '[Tap Edit Details to add Email]' : widget.config.email),
          _infoCard(Icons.location_on, 'Studio Address', widget.config.address.isEmpty ? '[Tap Edit Details to add Studio Address]' : widget.config.address),
          _infoCard(Icons.map, 'Google Maps Link', widget.config.mapsUrl.isEmpty ? '[Tap Edit Details to add Google Maps URL]' : widget.config.mapsUrl),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: ElevatedButton.icon(onPressed: () => widget.config.makeCall(context), icon: const Icon(Icons.call), label: const Text('Call Now'))),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(foregroundColor: AppTheme.pureWhite, side: const BorderSide(color: Color(0xFF25D366)), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () => widget.config.openWhatsApp(context),
                  icon: const Icon(Icons.chat, color: Color(0xFF25D366)),
                  label: const Text('WhatsApp'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(foregroundColor: AppTheme.champagneGold, side: const BorderSide(color: AppTheme.champagneGold), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () => widget.config.openMaps(context),
            icon: const Icon(Icons.directions),
            label: const Text('Open Google Maps Location'),
          ),
        ],
      ],
    );
  }

  Widget _editField(TextEditingController ctrl, String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: const TextStyle(color: AppTheme.pureWhite),
        decoration: InputDecoration(labelText: label, labelStyle: const TextStyle(color: AppTheme.mutedSilver), prefixIcon: Icon(icon, color: AppTheme.champagneGold), filled: true, fillColor: AppTheme.charcoalCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.charcoalCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.goldBorder)),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.champagneGold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppTheme.mutedSilver, fontSize: 11.5)),
                const SizedBox(height: 3),
                Text(value, style: const TextStyle(color: AppTheme.pureWhite, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
