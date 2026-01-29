import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/Themes/app_theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String goalDescription;
  final String date;

  const MainAppBar({
    super.key,
    required this.userName,
    required this.goalDescription,
    required this.date,
  });

  // This defines the exact height the Scaffold will reserve for your widget
  @override
  Size get preferredSize => const Size.fromHeight(138.0);
List<BoxShadow> get _headerShadow => [
        // 1. Ambient Shadow: Large blur, low opacity for soft transition
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 30,
          offset: const Offset(0, 15),
        ),
        // 2. Contact Shadow: Tighter blur, slightly more opacity for definition
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      decoration: _buildBackgroundDecoration(theme.colorScheme.primary),
      child: SafeArea( // Ensures content doesn't hit the status bar/notch
        bottom: false,
        child: Padding(
          padding: _headerPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGreeting(theme.textTheme),
              const SizedBox(height: 8),
              _buildGoalAndDateRow(theme.textTheme),
            ],
          ),
        ),
      ),
    );
  }

  // --- Style Extraction (O in SOLID: Open for extension) ---

  EdgeInsets get _headerPadding => const EdgeInsets.symmetric(horizontal: 16.0);

  BoxDecoration _buildBackgroundDecoration(Color color) {
    return BoxDecoration(
      boxShadow: _headerShadow,
      color: color,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    );
  }

  // --- Sub-Widgets (SRP: Single Responsibility Principle) ---
Widget _buildGreeting(TextTheme textTheme) {
    return Text(
      'Hi $userName',
      style: GoogleFonts.inter(
        textStyle: textTheme.displayMedium, // Base size/weight from theme
        color: const Color(0xFFF3E9E2),
      ),
    );
  }

  Widget _buildGoalAndDateRow(TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: _buildGoalText(textTheme)),
        const SizedBox(width: 12),
        _buildDateText(textTheme),
      ],
    );
  }

  Widget _buildGoalText(TextTheme textTheme) {
    return Text(
      goalDescription,
      style: textTheme.bodyLarge?.copyWith(
        color: AppTheme.lightTheme.cardColor
      ),
    );
  }

  Widget _buildDateText(TextTheme textTheme) {
    return Text(
      date.toUpperCase(),
      style: textTheme.bodyMedium?.copyWith( fontSize: 16,
        color: AppTheme.lightTheme.canvasColor
      ),
    );
  }
}