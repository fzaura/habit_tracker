import 'package:flutter/material.dart';
import 'package:habit_tracker/presentation/Widgets/icons/habit_icons.dart';

class HabitaNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HabitaNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Directly using the primary color from your provided AppTheme (_accentAction)
final backgroundColor = theme.colorScheme.primary.withValues(alpha: 0.7);
    return Container(
      width: 440,
      height: 58,
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      padding: _navbarPadding,
      decoration: _navbarDecoration(backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildNavItems(),
      ),
    );
  }

  // --- Specifications & Styling ---

  EdgeInsets get _navbarPadding => const EdgeInsets.only(
        top: 6,
        bottom: 6,
        left: 20,
        right: 20,
      );

  BoxDecoration _navbarDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // --- Item Mapping (Clean Architecture) ---

  List<Widget> _buildNavItems() {
    // List of "Vector" icons based on your image
    final List<IconData> icons = [
      Icons.home_outlined,
      Icons.grid_view_rounded, // For the diamond/grid vector
      Icons.format_list_bulleted_rounded,
      Icons.fitness_center_rounded,
      Icons.settings_outlined,
    ];

    return icons.asMap().entries.map((entry) {
      return _buildSingleItem(
        icon: entry.value,
        index: entry.key,
      );
    }).toList();
  }
Widget _buildSingleItem({required IconData icon, required int index}) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: HabitaIcon(
          icon: icon, 
          isSelected: isSelected,
        ),
      ),
    );
  }
}