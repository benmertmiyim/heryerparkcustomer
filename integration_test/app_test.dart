import 'package:customer/ui/components/profile_list_tile.dart';
import 'package:customer/ui/screen/main/home_screen.dart';
import 'package:customer/ui/screen/main/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:integration_test/integration_test.dart';


import 'package:customer/main.dart' as app;
import 'package:line_icons/line_icon.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {


  group(' Group of Customer Integration Tests ', () {

    testWidgets('- Integration Tests - ', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.pumpWidget(app.MyApp());
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

//REGISTER
//Registered user should not be registered again
      await tester.tap(find.byKey(Key('no_account')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('email_reg')), 'ayseguleyrice@gmail.com');
      await tester.enterText(find.byKey(Key('name_reg')), 'ayseguleyrice');
      await tester.enterText(find.byKey(Key('password_reg')), '123456');
      await tester.enterText(find.byKey(Key('password2_reg')), '123456');
      await tester.enterText(find.byKey(Key('phone_reg')), '05462615394');
      await tester.tap(find.byKey(Key('register')));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

//LOGIN

      await tester.enterText(find.byKey(Key('email')), 'ayseguleyrice@gmail.com');
      await tester.enterText(find.byKey(Key('password')), '123456');
      await tester.tap(find.byKey(Key('passs')));
      await Future.delayed(Duration(seconds: 1)); // Delayed 1 sec
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('enter')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('bell')));
      await tester.pumpAndSettle();

      final NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pop();
      await tester.pump();
      await Future.delayed(Duration(seconds: 1)); // 1 sec
      await tester.pumpAndSettle();

//SEE ALL PARKING LOTS
      await tester.tap(find.byKey(Key('seeAll')));
      await Future.delayed(Duration(seconds: 3));
      await tester.pump();



//SELECT DISPLAY PARKING LOTS


      final cardFinder = find.byType(Card).first;
      expect(cardFinder, findsOneWidget);
      await tester.tap(cardFinder);
      await tester.pump();
      await Future.delayed(Duration(seconds: 2));
      await tester.pump();


      final NavigatorState navigator2 = tester.state(find.byType(Navigator));
      navigator2.pop();
      await tester.pump();

 //FILTERING
      await tester.tap(find.byKey(Key('filtering')));
      await tester.pumpAndSettle();


      final NavigatorState navigator3 = tester.state(find.byType(Navigator));
      navigator3.pop();
      await tester.pump();


//MAP SCREEN
      await tester.tap(find.byKey(Key('map')));
      await tester.pump();

//qr screen
      await tester.tap(find.byKey(Key('qr')));
      await Future.delayed(Duration(seconds: 4));
      await tester.pumpAndSettle();


//PROFILE SCREEN

      await tester.tap(find.byKey(Key('profile')));
      await Future.delayed(Duration(seconds: 2));
      await tester.pumpAndSettle();

//COUPONS SCREEN
      final listTile2 = find.text('coupons');
      expect(listTile2, findsOneWidget);
      await tester.tap(find.text('coupons'));
      await Future.delayed(Duration(seconds: 4));













      //await tester.tap(find.byKey(Key('history')));
      //await tester.pumpAndSettle();

      //await tester.tap(find.byKey(Key('history2')));
      //await tester.pump();

      //await tester.drag(find.byKey(Key("history2")), Offset(0.0, 300.0));
      //await tester.pumpAndSettle();
      //final NavigatorState navigator3 = tester.state(find.byType(Navigator));
     // navigator3.pop();


      /*await tester.tap(find.byKey(Key('profilesettings')));
      await tester.pump();
      final NavigatorState navigator5 = tester.state(find.byType(Navigator));
      navigator5.pop();

      await tester.tap(find.byKey(Key('other')));
      await tester.pump();
      final NavigatorState navigator6 = tester.state(find.byType(Navigator));
      navigator6.pop();


       */



    /*
    -----------------------------------------------------------------------------

    await tester.tap(find.byKey(Key('credit')));
      await tester.pump();
      final NavigatorState navigator4 = tester.state(find.byType(Navigator));
      navigator4.pop();

      await tester.tap(find.byKey(Key('profilesettings')));
      await tester.pump();
      final NavigatorState navigator5 = tester.state(find.byType(Navigator));
      navigator5.pop();

      await tester.tap(find.byKey(Key('other')));
      await tester.pump();
      final NavigatorState navigator5 = tester.state(find.byType(Navigator));
      navigator5.pop();





      await tester.tap(find.byKey(Key('add')));
      await tester.pump();


      ---------------------------------------------------------------------------
*/











    });

  });

}