import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAddPressed;
  final bool viewDetails;

  const SectionHeader({
    super.key,
    required this.title,
    this.onAddPressed,
    this.viewDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 440,
      // As per spec
      height: viewDetails ? 58 : 31, // As per spec
      padding: const EdgeInsets.symmetric(horizontal: 20), // Left/Right padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(viewDetails)
          _buildColumn(context),
        if(viewDetails==false)
          _buildTitleText(context),
          _buildAddAction(theme.colorScheme.primary),
        ],
      ),
    );
  }

  // --- Clean Methods (SRP) ---

  Widget _buildTitleText(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 25, // As per spec
        fontWeight: FontWeight.w600, // Exact Semi-Bold
        height: viewDetails ? 1.36 : 1.26, // 126% line height
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildAddAction(Color iconColor) {
    return GestureDetector(
      onTap: onAddPressed,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        fontWeight: FontWeight.w100,
        Icons.add,
        size: 29,
        color: iconColor, // Using _accentAction from AppTheme
      ),
    );
  }

  Widget _buildColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildTitleText(context),const SizedBox(height: 3,),_buildViewDetailsText(context)],
    );
  }

  Widget _buildViewDetailsText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle view details tap
      },
      child: Text(
        'View Details',
        style: GoogleFonts.inter(
          decoration: TextDecoration.underline,
          fontSize: 14, // As per spec
          fontWeight: FontWeight.w400, // Medium weight
          color: Theme.of(
            context,
          ).colorScheme.primary, // Your _mainColor/accentAction
        ),
      ),
    );
  }
}
