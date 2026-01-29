import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool showAddButton;
  final VoidCallback? onAddPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.showAddButton = true,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: 440, // As per spec
      height: 31,  // As per spec
      padding: const EdgeInsets.symmetric(horizontal: 20), // Left/Right padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitleText(theme.textTheme),
          if (showAddButton) _buildAddAction(theme.colorScheme.primary),
        ],
      ),
    );
  }

  // --- Clean Methods (SRP) ---

  Widget _buildTitleText(TextTheme textTheme) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 25, // As per spec
        fontWeight: FontWeight.w600, // Exact Semi-Bold
        height: 1.26, // 126% line height
        color: const Color(0xFF283D3B), // Your _mainColor/accentAction
      ),
    );
  }

  Widget _buildAddAction(Color iconColor) {
    return GestureDetector(
      onTap: onAddPressed,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        Icons.add,
        size: 29, 
        color: iconColor, // Using _accentAction from AppTheme
      ),
    );
  }
}