import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/core/view/notification_view.dart';
import 'package:customer/core/view/promotion_view.dart';
import 'package:customer/firebase_options.dart';
import 'package:customer/l10n/l10n.dart';
import 'package:customer/locator.dart';
import 'package:customer/provider/local_provider.dart';
import 'package:customer/ui/screen/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthView(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationView(),
        ),
        ChangeNotifierProvider(
          create: (context) => PromotionView(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationView(),
        ),
      ],
      child: MaterialApp(
        title: "HerYerPark",
        debugShowCheckedModeBanner: false,
        theme: FlexThemeData.light(
          fontFamily: GoogleFonts.roboto().fontFamily,
          scheme: FlexScheme.bahamaBlue,
          appBarElevation: 0.5,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.bahamaBlue,
          fontFamily: GoogleFonts.roboto().fontFamily,
          appBarElevation: 2,
        ),
        themeMode: ThemeMode.system,
        locale: Get.deviceLocale,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const LandingScreen(),
      ),
    );
  }
}
