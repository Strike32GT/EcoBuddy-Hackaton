import 'package:flutter/material.dart';

import '../../../../core/theme/ecobuddy_colors.dart';
import '../../../../core/widgets/app_chrome.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const EcoBuddyHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 136),
              children: const [
                _WelcomeBlock(),
                SizedBox(height: 24),
                _ChatBubble(text: 'Como reciclo una caja de pizza?', isUser: true),
                SizedBox(height: 16),
                _ChatBubble(
                  text: 'Las cajas de pizza van con el carton si estan limpias. Retira restos de comida y separa la parte manchada para compostaje.',
                  isUser: false,
                  tag: 'Tip del dia',
                ),
                SizedBox(height: 14),
                _SuggestionRow(),
                SizedBox(height: 16),
                _ChatBubble(
                  text: 'Sabias que reciclar una tonelada de papel salva 17 arboles? Sigue asi, Guardian Verde.',
                  isUser: false,
                ),
              ],
            ),
          ),
          const _Composer(),
        ],
      ),
    );
  }
}

class _WelcomeBlock extends StatelessWidget {
  const _WelcomeBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 68,
          height: 68,
          decoration: const BoxDecoration(
            color: EcoBuddyColors.primaryFixedDim,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.psychology_alt_rounded, color: EcoBuddyColors.onPrimaryContainer, size: 34),
        ),
        const SizedBox(height: 12),
        Text(
          'Hola de nuevo!',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: EcoBuddyColors.primary),
        ),
        const SizedBox(height: 6),
        Text(
          'Estoy listo para ayudarte con reciclaje y vida sostenible.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.isUser, this.tag});

  final String text;
  final bool isUser;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 292),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUser ? EcoBuddyColors.primary : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isUser ? 18 : 4),
          topRight: Radius.circular(isUser ? 4 : 18),
          bottomLeft: const Radius.circular(18),
          bottomRight: const Radius.circular(18),
        ),
        border: isUser ? null : Border.all(color: EcoBuddyColors.outlineVariant.withValues(alpha: 0.35)),
        boxShadow: const [
          BoxShadow(color: Color(0x100D1C2E), blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isUser ? Colors.white : EcoBuddyColors.onSurface,
                ),
          ),
          if (tag != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: EcoBuddyColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                tag!.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: EcoBuddyColors.primary),
              ),
            ),
          ],
        ],
      ),
    );

    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) ...[
          const CircleAvatar(
            radius: 17,
            backgroundColor: EcoBuddyColors.primaryContainer,
            child: Icon(Icons.auto_awesome_rounded, color: EcoBuddyColors.onPrimaryContainer, size: 18),
          ),
          const SizedBox(width: 10),
        ],
        bubble,
      ],
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _SuggestionChip(icon: Icons.compost_rounded, label: 'Compostaje casero'),
          SizedBox(width: 10),
          _SuggestionChip(icon: Icons.recycling_rounded, label: 'Puntos limpios'),
        ],
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () {},
      avatar: Icon(icon, color: EcoBuddyColors.secondary, size: 18),
      label: Text(label),
      backgroundColor: Colors.white,
      side: const BorderSide(color: EcoBuddyColors.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [EcoBuddyColors.surface.withValues(alpha: 0), EcoBuddyColors.surface],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: EcoBuddyColors.outlineVariant.withValues(alpha: 0.3)),
          boxShadow: const [BoxShadow(color: Color(0x180D1C2E), blurRadius: 14, offset: Offset(0, 4))],
        ),
        child: Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Preguntale a EcoBuddy...',
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: EcoBuddyColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(12),
                minimumSize: const Size(44, 44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
