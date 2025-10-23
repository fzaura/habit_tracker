import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'terms_screen.dart';
import 'policy_screen.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Small helper that builds a tappable card used for each settings row.
  Widget _buildSettingCard({required BuildContext context, required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Setting',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cards list
              _buildSettingCard(
                context: context,
                title: 'Account',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountScreen())),
              ),

              _buildSettingCard(
                context: context,
                title: 'Term and Condition',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen())),
              ),

              _buildSettingCard(
                context: context,
                title: 'Policy',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PolicyScreen())),
              ),

              _buildSettingCard(
                context: context,
                title: 'About App',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())),
              ),

              // Expand to push content up if needed
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
