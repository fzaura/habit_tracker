import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoCard extends StatelessWidget {
  final String taskName;
  final bool isCompleted;

  const ToDoCard({super.key, required this.taskName, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 400, // Exact spec
      height: 59, // Exact spec
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Exact spec
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9), // Your background color
        borderRadius: BorderRadius.circular(6), // Exact spec
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          width: 0.7, // Exact spec
        ),
        boxShadow: [
          // Layer 1: The soft ambient glow (iPhone style)
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          // Layer 2: The sharp contact shadow for definition
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.20),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Exact spec
        children: [
          // Left Side: Bullet + Text
          Row(
            children: [
              _buildBullet(theme.colorScheme.primary),
              const SizedBox(width: 6),
              _buildText(taskName, theme),
            ],
          ),
          // Right Side: Checkbox
          _buildCustomCheckbox(theme.colorScheme.primary),
        ],
      ),
    );
  }

  Widget _buildText(String taskName, ThemeData theme) {
    return Text(
      taskName,
      style: GoogleFonts.inter(
        fontSize: 18,
        height: 1.26,
        fontWeight: FontWeight.w500,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildBullet(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.7),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCustomCheckbox(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 2.5),
      ),
      child: isCompleted ? Icon(Icons.check, size: 14, color: color) : null,
    );
  }
}
