import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile/main.dart';

void main() {
  testWidgets('EcoBuddy starts at login and enters chat', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: EcoBuddyApp()));

    expect(find.text('EcoBuddy'), findsOneWidget);
    expect(find.text('IA para tu hogar'), findsOneWidget);

    await tester.tap(find.text('Iniciar Sesion'));
    await tester.pumpAndSettle();

    expect(find.text('Hola de nuevo!'), findsOneWidget);
    expect(find.text('Preguntale a EcoBuddy...'), findsOneWidget);
  });
}
