import 'package:customer/ui/screen/main/home_screen.dart';
import 'package:customer/ui/screen/main/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:integration_test/integration_test.dart';


import 'package:customer/main.dart' as app;

void main() {


  group('integration testler grubu', () {

    testWidgets('integration testler yapiliyor', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpWidget(app.MyApp());
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();


     await tester.tap(find.byKey(Key('no_account')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('email_reg')), 'ayseguleyrice@gmail.com');
      await tester.enterText(find.byKey(Key('name_reg')), 'ayseguleyrice');
      await tester.enterText(find.byKey(Key('password_reg')), '123456');
      await tester.enterText(find.byKey(Key('password2_reg')), '123456');
      await tester.enterText(find.byKey(Key('phone_reg')), '05462615394');
      await tester.tap(find.byType(IconButton));


      await tester.pumpAndSettle();



      await tester.enterText(find.byKey(Key('email')), 'ayseguleyrice@gmail.com');
      await tester.enterText(find.byKey(Key('password')), '123456');
      await tester.tap(find.byKey(Key('passs')));
      await tester.pumpAndSettle();


      //await tester.tap(find.byType(IconButton));

      await tester.tap(find.byType(ElevatedButton));
      //await tester.tap(find.byKey(Key('qr')));
      //await tester.pumpAndSettle();
      await tester.pumpAndSettle();











    });

  });

}