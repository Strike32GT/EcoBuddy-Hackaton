import 'package:flutter/material.dart';

import '../../../../core/theme/ecobuddy_colors.dart';
import '../../../../core/widgets/app_chrome.dart';
import '../../domain/entities/mission.dart';

class MissionsPage extends StatelessWidget {
  const MissionsPage({super.key});

  static const missions = [
    Mission(
      title: 'Separar el plastico de la semana',
      reward: '200 pts',
      progress: 0.60,
      icon: Icons.recycling_rounded,
    ),
    Mission(
      title: 'Evitar bolsas de un solo uso hoy',
      reward: '50 pts',
      progress: 0.10,
      icon: Icons.shopping_bag_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUnlockedMission(context),
        backgroundColor: EcoBuddyColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.add_task_rounded),
      ),
      body: Column(
        children: [
          const EcoBuddyHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
              children: [
                Text('Hola, Guardian Verde!', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 6),
                Text(
                  'Sigue completando misiones para limpiar el planeta y ganar recompensas.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 28),
                const _SectionTitle(title: 'Misiones Activas', action: 'Ver todas'),
                const SizedBox(height: 12),
                for (final mission in missions) ...[
                  _MissionCard(mission: mission),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 18),
                const _SectionTitle(title: 'Canjear Premios', action: 'Marketplace'),
                const SizedBox(height: 12),
                const _RewardHero(),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(child: _RewardTile(icon: Icons.coffee_rounded, title: 'Cafe sostenible', points: '350 pts', color: EcoBuddyColors.secondary)),
                    SizedBox(width: 12),
                    Expanded(child: _RewardTile(icon: Icons.directions_bus_rounded, title: 'Bus electrico', points: '120 pts', color: EcoBuddyColors.error)),
                  ],
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Expanded(child: _RewardTile(icon: Icons.redeem_rounded, title: 'Tienda zero waste', points: '800 pts', color: EcoBuddyColors.primary)),
                    SizedBox(width: 12),
                    Expanded(child: _RewardTile(icon: Icons.park_rounded, title: 'Parque natural', points: '1,100 pts', color: EcoBuddyColors.outline)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showUnlockedMission(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const _UnlockedMissionSheet(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        Text(action, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: EcoBuddyColors.primary)),
      ],
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({required this.mission});

  final Mission mission;

  @override
  Widget build(BuildContext context) {
    return EcoCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: EcoBuddyColors.primaryContainer.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(mission.icon, color: EcoBuddyColors.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mission.title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
                    Text('Recompensa: ${mission.reward}', style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Progreso', style: Theme.of(context).textTheme.labelSmall),
              const Spacer(),
              Text('${(mission.progress * 100).round()}%', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: EcoBuddyColors.primary)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: mission.progress,
              minHeight: 10,
              backgroundColor: EcoBuddyColors.surfaceContainer,
              color: EcoBuddyColors.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardHero extends StatelessWidget {
  const _RewardHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [EcoBuddyColors.primary, EcoBuddyColors.tertiaryContainer],
        ),
        boxShadow: const [BoxShadow(color: Color(0x22006C49), blurRadius: 18, offset: Offset(0, 8))],
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -10,
            bottom: -20,
            child: Icon(Icons.forest_rounded, color: Color(0x33FFFFFF), size: 132),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)),
                child: Text('MAS CANJEADO', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: EcoBuddyColors.primary)),
              ),
              const SizedBox(height: 10),
              Text('Siembra 1 Arbol', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
              Text('500 pts - Proyecto Reforestacion', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RewardTile extends StatelessWidget {
  const _RewardTile({required this.icon, required this.title, required this.points, required this.color});

  final IconData icon;
  final String title;
  final String points;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return EcoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 14),
          Text(title, style: Theme.of(context).textTheme.labelLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
          Text(points, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _UnlockedMissionSheet extends StatelessWidget {
  const _UnlockedMissionSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
      decoration: const BoxDecoration(
        color: EcoBuddyColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 48, height: 5, decoration: BoxDecoration(color: EcoBuddyColors.outlineVariant, borderRadius: BorderRadius.circular(999))),
            const SizedBox(height: 26),
            Stack(
              clipBehavior: Clip.none,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: EcoBuddyColors.primaryFixed,
                  child: Icon(Icons.track_changes_rounded, color: EcoBuddyColors.primary, size: 48),
                ),
                Positioned(
                  right: -24,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: EcoBuddyColors.secondary, borderRadius: BorderRadius.circular(999)),
                    child: Text('+50 creditos', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Mision Desbloqueada!', style: Theme.of(context).textTheme.headlineLarge, textAlign: TextAlign.center),
            const SizedBox(height: 14),
            EcoCard(
              child: Text(
                'Mision: limpia y aplana 3 cajas de carton esta semana para reducir espacio en el contenedor.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.check_circle_rounded),
              label: const Text('Aceptar Mision'),
              style: FilledButton.styleFrom(
                backgroundColor: EcoBuddyColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(54),
                shape: const StadiumBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
