import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/ecobuddy_colors.dart';
import '../../../../core/widgets/app_chrome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePassword = true;

  void _enterApp() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _OrganicBackdrop(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
              child: Column(
                children: [
                  Image.asset('assets/images/ecobuddy_logo.png', height: 220),
                  Text(
                    'EcoBuddy',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: EcoBuddyColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'IA para tu hogar',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  EcoCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _FieldLabel('Correo electronico'),
                        const SizedBox(height: 8),
                        const TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                            hintText: 'nombre@ejemplo.com',
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _FieldLabel('Contrasena'),
                            Text(
                              'Olvide mi clave',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: EcoBuddyColors.secondary,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            hintText: '********',
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                _hidePassword = !_hidePassword;
                              }),
                              icon: Icon(
                                _hidePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        FilledButton.icon(
                          onPressed: _enterApp,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text('Iniciar Sesion'),
                          style: FilledButton.styleFrom(
                            backgroundColor: EcoBuddyColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: const StadiumBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Expanded(child: Divider(color: EcoBuddyColors.outlineVariant)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text('O continua con', style: Theme.of(context).textTheme.labelSmall),
                            ),
                            const Expanded(child: Divider(color: EcoBuddyColors.outlineVariant)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: _SocialButton(icon: Icons.g_mobiledata_rounded, label: 'Google')),
                            const SizedBox(width: 12),
                            Expanded(child: _SocialButton(icon: Icons.apple_rounded, label: 'Apple')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text.rich(
                    TextSpan(
                      text: 'No tienes una cuenta? ',
                      children: [
                        TextSpan(
                          text: 'Crear cuenta nueva',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: EcoBuddyColors.primary,
                              ),
                        ),
                      ],
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: 0.8),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: EcoBuddyColors.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 13),
        side: const BorderSide(color: EcoBuddyColors.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class _OrganicBackdrop extends StatelessWidget {
  const _OrganicBackdrop();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: EcoBuddyColors.surface,
        gradient: RadialGradient(
          center: Alignment(-0.9, -0.8),
          radius: 0.9,
          colors: [Color(0x1510B981), EcoBuddyColors.surface],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}
