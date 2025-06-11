import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('register then login', (tester) async {
    app.main(); // Uruchom aplikację
    await tester.pumpAndSettle();

    // Kliknij "Załóż konto"
    final loginButton = find.byKey(const ValueKey('login_icon_button'));
    expect(loginButton, findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();


    final registerationButton = find.byKey(ValueKey('create_account_button'));
    await tester.tap(registerationButton);
    await tester.pumpAndSettle();

    // Sprawdź, czy przeniosło na ekran rejestracji
    expect(find.text('Załóż konto!'), findsOneWidget);


    // Znajdź pola tekstowe po etykietach
    final emailField = find.widgetWithText(TextFormField, 'Email');
    final passwordField = find.widgetWithText(TextFormField, 'Hasło');

    // Wpisz dane testowe
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'Qwerty1@3');


    // Znajdź i kliknij przycisk "Załóż konto"
    final registerButton = find.text('Załóż konto');
    expect(registerButton, findsOneWidget);

    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Po rejestracji HomePage
    expect(find.text('Szukaj produktów'), findsOneWidget);

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    expect(find.text('Witaj ponownie!'), findsOneWidget);


    // Wpisz dane testowe
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'Qwerty1@3');


    final loginFormButton = find.text('Zaloguj się');
    expect(loginFormButton, findsOneWidget);

    await tester.tap(loginFormButton);
    await tester.pumpAndSettle();


    

    // Sprawdź, czy znowu jesteś w HomePage
    expect(find.text('Szukaj produktów'), findsOneWidget);
  });
}
