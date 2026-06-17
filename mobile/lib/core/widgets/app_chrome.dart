import 'package:flutter/material.dart';

import '../theme/ecobuddy_colors.dart';

class EcoBuddyHeader extends StatelessWidget {
  const EcoBuddyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
        child: Row(
          children: [
            Image.asset(
              'assets/images/EcoBuddyRecortado.png',
              height: 44,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            const PointsPill(points: '1,250'),
          ],
        ),
      ),
    );
  }
}

class PointsPill extends StatelessWidget {
  const PointsPill({super.key, required this.points});

  final String points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: EcoBuddyColors.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140D1C2E),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.stars_rounded, size: 18, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            '$points pts',
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class EcoCard extends StatelessWidget {
  const EcoCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: EcoBuddyColors.outlineVariant.withValues(alpha: 0.35)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140D1C2E),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
