import 'package:customer/l10n/l10n.dart';
import 'package:customer/provider/local_provider.dart';
import 'package:customer/ui/screen/main/home_screen.dart';
import 'package:customer/ui/screen/main/notification_screen.dart';
import 'package:customer/ui/screen/main/profile_screen.dart';
import 'package:customer/ui/screen/main/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    //HomeScreen(),
    //MapScreen(),
    //QRScreen(),
    //ProfileScreen(),
    HomeScreen(),
    Container(),
    QRScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "HerYer",
              style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontStyle: FontStyle.italic),
            ),
            TextSpan(
              text: "Park",
              style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LineIcons.bell),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              gap: 8,
              iconSize: 24,
              activeColor: theme.colorScheme.onPrimary,
              tabBackgroundColor: theme.colorScheme.primary,
              color: theme.colorScheme.onBackground.withAlpha(220),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: const Duration(milliseconds: 300),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: AppLocalizations.of(context).bottom_nav_home,
                ),
                GButton(
                  icon: LineIcons.map,
                  text: AppLocalizations.of(context).bottom_nav_map,
                ),
                GButton(
                  icon: LineIcons.qrcode,
                  text: AppLocalizations.of(context).bottom_nav_qr,
                ),
                GButton(
                  icon: LineIcons.user,
                  text: AppLocalizations.of(context).bottom_nav_profile,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (i) {
                setState(() {
                  _selectedIndex = i;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
