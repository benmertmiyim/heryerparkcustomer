import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:customer/ui/components/profile_list_tile.dart';
import 'package:customer/ui/components/select_language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showNotification = true;

  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).profile_screen_settings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  AppLocalizations.of(context).profile_screen_notifications,
                ),
              ),
              Switch(
                onChanged: (bool value) {
                  setState(() {
                    _showNotification = value;
                  });
                },
                value: _showNotification,
              )
            ],
          ),
          const Divider(
            thickness: 0.5,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              AppLocalizations.of(context).profile_screen_other,
            ),
          ),
          ProfileListTile(
            title: AppLocalizations.of(context).other_screen_privacysecurity,
            icon: MdiIcons.lockOutline,
            onTap: Container(),
          ),
          Divider(),
          ProfileListTile(
            title: AppLocalizations.of(context).other_screen_about,
            icon: MdiIcons.helpCircleOutline,
            onTap: Container(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Version ${packageInfo.version}",
                ),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(
                  brightness == Brightness.dark
                      ? "assets/images/mandalinasoft-horizontal-white-logo.png"
                      : "assets/images/mandalinasoft-horizontal-black-logo.png",
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
