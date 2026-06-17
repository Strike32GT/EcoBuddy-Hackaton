import 'package:flutter/material.dart';

import '../../../../core/theme/ecobuddy_colors.dart';
import '../../../../core/widgets/app_chrome.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const EcoBuddyHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 120),
              children: const [
                _ProfileHero(),
                SizedBox(height: 28),
                _PreferenceSection(),
                SizedBox(height: 28),
                _ReferralCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 128,
              height: 128,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [EcoBuddyColors.primary, EcoBuddyColors.tertiaryContainer]),
              ),
              child: const CircleAvatar(
                backgroundColor: EcoBuddyColors.surface,
                child: Icon(Icons.person_rounded, color: EcoBuddyColors.primary, size: 76),
              ),
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: EcoBuddyColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: EcoBuddyColors.surface, width: 3),
                ),
                child: const Icon(Icons.verified_rounded, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text('Alfredo Navarro', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.workspace_premium_rounded, color: EcoBuddyColors.primary, size: 18),
            const SizedBox(width: 4),
            Text('Nivel: Guardian Verde', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: EcoBuddyColors.primary)),
          ],
        ),
        const SizedBox(height: 22),
        const Row(
          children: [
            Expanded(child: _StatCard(label: 'Misiones', value: '42')),
            SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'CO2 Ahorrado', value: '12.4 kg', highlight: true)),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, this.highlight = false});

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return EcoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: highlight ? EcoBuddyColors.primary : EcoBuddyColors.onSurface,
                ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceSection extends StatelessWidget {
  const _PreferenceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text('Preferencias y Cuenta', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: EcoBuddyColors.outline)),
        ),
        const _SettingsTile(icon: Icons.person_outline_rounded, title: 'Editar Perfil'),
        const _SettingsTile(icon: Icons.home_rounded, title: 'Configuracion del Hogar'),
        const _SettingsTile(icon: Icons.notifications_none_rounded, title: 'Notificaciones de Recordatorio'),
        const _SettingsTile(icon: Icons.smart_toy_outlined, title: 'Preferencias del Agente de IA', subtitle: 'Modo Asistente Activo'),
        const SizedBox(height: 10),
        const _SettingsTile(icon: Icons.logout_rounded, title: 'Cerrar Sesion', danger: true),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.danger = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? EcoBuddyColors.error : EcoBuddyColors.primary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: EcoCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: danger ? color : EcoBuddyColors.onSurface)),
                  if (subtitle != null) Text(subtitle!, style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: danger ? color.withValues(alpha: 0.5) : EcoBuddyColors.outlineVariant),
          ],
        ),
      ),
    );
  }
}

class _ReferralCard extends StatelessWidget {
  const _ReferralCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(colors: [EcoBuddyColors.primary, EcoBuddyColors.primaryContainer]),
        boxShadow: const [BoxShadow(color: Color(0x26006C49), blurRadius: 18, offset: Offset(0, 8))],
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -12,
            bottom: -20,
            child: Icon(Icons.group_rounded, color: Color(0x24FFFFFF), size: 100),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invita a tus Amigos', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
              const SizedBox(height: 6),
              Text(
                'Gana 500 puntos por cada guardian que se una al ciclo limpio.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.9)),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: EcoBuddyColors.primary,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Compartir Enlace'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
