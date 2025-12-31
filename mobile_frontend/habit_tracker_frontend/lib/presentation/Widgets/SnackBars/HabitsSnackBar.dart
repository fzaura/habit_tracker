import 'dart:ui';
import 'package:flutter/material.dart';

class HabitASnackBar extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;

  const HabitASnackBar({
    super.key,
    required this.message,
    this.icon = Icons.check_circle_outline_rounded,
    this.backgroundColor = const Color(0xFF1A1A1A), // Modern Deep Grey/Black
  });

  /// Static helper to show the snackbar easily
  static void show(BuildContext context, String message, {IconData? icon, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        duration: const Duration(seconds: 3),
        content: HabitASnackBar(
          message: message,
          icon: icon ?? Icons.check_circle_outline_rounded,
          backgroundColor: color ?? const Color(0xFF1A1A1A),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.85),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // Shrinks to fit content
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}