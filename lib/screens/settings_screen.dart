import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            'Appearance',
            [
              ListTile(
                leading: const Icon(Icons.palette),
                title: const Text('Theme'),
                subtitle: const Text('Light'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Theme selection
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.high_quality),
                title: const Text('High Contrast'),
                subtitle: const Text('Better visibility'),
                value: false,
                onChanged: (value) {
                  // Toggle high contrast
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.animation),
                title: const Text('Reduced Motion'),
                subtitle: const Text('Minimize animations'),
                value: false,
                onChanged: (value) {
                  // Toggle reduced motion
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Audio',
            [
              SwitchListTile(
                secondary: const Icon(Icons.record_voice_over),
                title: const Text('Voice Announcements'),
                subtitle: const Text('Speak exercise names and cues'),
                value: true,
                onChanged: (value) {
                  // Toggle TTS
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.volume_up),
                title: const Text('Sound Effects'),
                subtitle: const Text('Beeps and transition sounds'),
                value: true,
                onChanged: (value) {
                  // Toggle sound effects
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Voice Language'),
                subtitle: const Text('English (US)'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Language selection
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Defaults',
            [
              ListTile(
                leading: const Icon(Icons.timer),
                title: const Text('Default Routine Length'),
                subtitle: const Text('5 minutes'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Duration picker
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.block),
                title: const Text('No Floor Exercises'),
                subtitle: const Text('Avoid moves requiring floor contact'),
                value: false,
                onChanged: (value) {
                  // Toggle no floor default
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'Accessibility',
            [
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('Text Size'),
                subtitle: const Text('Default'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Text size picker
                },
              ),
              SwitchListTile(
                secondary: const Icon(Icons.subtitles),
                title: const Text('Always Show Captions'),
                subtitle: const Text('Display text for all audio cues'),
                value: true,
                onChanged: (value) {
                  // Toggle captions
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            'About',
            [
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Version'),
                subtitle: const Text('0.1.0'),
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help & Support'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Help screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Privacy policy
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}