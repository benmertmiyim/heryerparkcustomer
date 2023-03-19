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
      await tester.tap(find.byKey(Key('enter')));
      await tester.pumpAndSettle();



      /*await tester.tap(find.byKey(Key('bell')));
      await tester.pump();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();


       */


      /*await tester.tap(find.byKey(Key('seeAll')));
      await tester.pump();
      await tester.tap(find.byType(IconButton));
      await tester.pump();

       */
      /*final textButtonFinder = find.byKey(Key('seeAll'));

      // Ensure the TextButton exists


      // Tap the TextButton
      await tester.tap(textButtonFinder);

      // Wait for the navigation to complete
      await tester.pumpAndSettle();


       */


      // Tap the button


      await tester.tap(find.byKey(Key('qr')));
      await tester.pump();
      await tester.tap(find.byKey(Key('map')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('profile')));
      await tester.pumpAndSettle();

     /* final Finder tileFinder = find.byKey(Key("notifications"));

      // Tap the widget
      await tester.tap(tileFinder);

      // Wait for the frame to be rendered
      await tester.pump();

      */
      //await tester.tap(find.byKey(Key('notifications')));
      //await tester.pump();
      //await tester.tap(find.byType(ProfileListTile));
      //await tester.pump();


      /*await tester.tap(find.byKey(Key('a')));

      await tester.pump();
      await tester.tap(find.byKey(Key('map')));
      await tester.pump();



       */


      /*await tester.tap(find.byKey(Key('rate')));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key('comment')), 'nice parking');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key('sentMessage')));
      await tester.pumpAndSettle();


       */











      //await tester.tap(find.byType(IconButton));

      //await tester.tap(find.byType(ElevatedButton));
      //await tester.tap(find.byKey(Key('qr')));
      //await tester.pumpAndSettle();
      //await tester.pumpAndSettle();











    });

  });

}