import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/ecobuddy_colors.dart';
import '../../../chat_ai/presentation/pages/chat_page.dart';
import '../../../missions/presentation/pages/missions_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../providers/navigation_provider.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    const pages = [ChatPage(), MissionsPage(), ProfilePage()];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: EcoBuddyColors.surface.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: EcoBuddyColors.outlineVariant.withValues(alpha: 0.28)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x160D1C2E),
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(index: 0, icon: Icons.chat_bubble_rounded, label: 'Chat', selectedIndex: currentIndex),
              _NavItem(index: 1, icon: Icons.workspace_premium_rounded, label: 'Misiones', selectedIndex: currentIndex),
              _NavItem(index: 2, icon: Icons.person_rounded, label: 'Perfil', selectedIndex: currentIndex),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends ConsumerWidget {
  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.selectedIndex,
  });

  final int index;
  final IconData icon;
  final String label;
  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = index == selectedIndex;
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () => ref.read(navigationIndexProvider.notifier).state = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? EcoBuddyColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? EcoBuddyColors.onPrimaryContainer : EcoBuddyColors.onSurfaceVariant,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isActive ? EcoBuddyColors.onPrimaryContainer : EcoBuddyColors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
