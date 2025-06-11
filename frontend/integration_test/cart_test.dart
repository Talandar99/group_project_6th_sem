import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
IntegrationTestWidgetsFlutterBinding.ensureInitialized();

testWidgets('cart', (tester) async {
    app.main(); // Uruchom aplikację
    await tester.pumpAndSettle();

    final toCartButtons = find.widgetWithText(ElevatedButton, 'Do koszyka');
    final toCartButtonsCount = toCartButtons.evaluate().length;
    final allButtons = toCartButtons.evaluate().toList();
    

    if (toCartButtonsCount == 0) {
        fail('Nie znaleziono żadnych przycisków "Do koszyka"!');
    }


    final toClickCount = toCartButtonsCount >= 3 ? 3 : toCartButtonsCount;



    for (int i = 0; i < toClickCount; i++) {
        final element = allButtons[i];
        print('Klikam przycisk nr $i');

        await tester.tap(find.byElementPredicate((el) => el == element));
        await tester.pumpAndSettle();
    }



    final gotoCartButton = find.byKey(ValueKey('cart_icon_button'));
    await tester.tap(gotoCartButton);
    await tester.pumpAndSettle();


    final orderForButton = find.byKey(ValueKey('order_for_button'));
    await tester.tap(orderForButton);
    await tester.pumpAndSettle();


    

    final payButton = find.byKey(ValueKey('pay_button'));
    await tester.tap(payButton);
    await tester.pumpAndSettle();
    
    await tester.pump(const Duration(seconds: 3));



    expect(find.text('Twój koszyk jest pusty'), findsOneWidget);


});
}
