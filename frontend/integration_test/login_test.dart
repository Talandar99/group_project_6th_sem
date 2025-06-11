import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('register then login', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final loginButton = find.byKey(const ValueKey('login_icon_button'));
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    final registerationButton = find.byKey(ValueKey('create_account_button'));
    await tester.tap(registerationButton);
    await tester.pumpAndSettle();

    expect(find.text('Załóż konto!'), findsOneWidget);

    final emailField = find.widgetWithText(TextFormField, 'Email');
    final passwordField = find.widgetWithText(TextFormField, 'Hasło');

    await tester.enterText(emailField, 'tasdaest@example.com');
    await tester.enterText(passwordField, 'Qasdsawerty1@3');

    final registerButton = find.text('Załóż konto');
    expect(registerButton, findsOneWidget);

    await tester.tap(registerButton);
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.pumpAndSettle(Duration(seconds: 3));

    //final goBackButton = find.byKey(ValueKey('go_back'));
    //await tester.tap(goBackButton);
    //await tester.pumpAndSettle();

    expect(find.text('Szukaj produktów'), findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Witaj ponownie!'), findsOneWidget);

    await tester.enterText(emailField, 'tasdaest@example.com');
    await tester.enterText(passwordField, 'Qasdsawerty1@3');

    final loginFormButton = find.text('Zaloguj się');
    expect(loginFormButton, findsOneWidget);

    await tester.tap(loginFormButton);
    await tester.pumpAndSettle();

    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.pumpAndSettle(Duration(seconds: 3));

    expect(find.text('Szukaj produktów'), findsOneWidget);
  });
}
