import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/router.dart';

import 'core/theme/ecobuddy_theme.dart';

void main() {
  runApp(const ProviderScope(child: EcoBuddyApp()));
}

class EcoBuddyApp extends ConsumerWidget {
  const EcoBuddyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'EcoBuddy',
      theme: EcoBuddyTheme.light(),
      routerConfig: router,
    );
  }
}
