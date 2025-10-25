import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utility/ProgressScreenUtil/statelessWidgets/Detailed%20Goals%20Lister/utilProgressScreen.dart';
import 'package:habit_tracker/core/utility/SettingsScreenUtil/utilSettingsScreen.dart';
import 'account_screen.dart';
import 'terms_screen.dart';
import 'policy_screen.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Small helper that builds a tappable card used for each settings row.

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
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cards list
              Utilsettingsscreen.buildSettingCard(
                context: context,
                title: 'Account',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AccountScreen()),
                ),
              ),

              Utilsettingsscreen.buildSettingCard(
                context: context,
                title: 'Term and Condition',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermsScreen()),
                ),
              ),

              Utilsettingsscreen.buildSettingCard(
                context: context,
                title: 'Policy',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PolicyScreen()),
                ),
              ),

              Utilsettingsscreen.buildSettingCard(
                context: context,
                title: 'About App',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                ),
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
