import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/profile_list_tile.dart';
import 'package:customer/ui/screen/auth/login_screen.dart';
import 'package:customer/ui/screen/main/campaing_screen.dart';
import 'package:customer/ui/screen/main/coupon_screen.dart';
import 'package:customer/ui/screen/main/history_screen.dart';
import 'package:customer/ui/screen/main/notification_screen.dart';
import 'package:customer/ui/screen/main/other_screen.dart';
import 'package:customer/ui/screen/main/payment_methods_screen.dart';
import 'package:customer/ui/screen/main/settings_screen.dart';
import 'package:customer/ui/screen/main/support_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthView authView;
  final ImagePicker _picker = ImagePicker();
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authView = Provider.of<AuthView>(context);
    theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: authView.authProcess == AuthProcess.idle
                      ? InkWell(
                          onTap: () async {
                            await _picker
                                .pickImage(source: ImageSource.gallery)
                                .then((value) async {
                              if (value == null) {
                                return;
                              } else {
                                var file = File(value.path);
                                await authView
                                    .changeCustomerImage(file)
                                    .then((value) {
                                  if (value != AppLocalizations.of(context).profile_screen_swworng) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context).profile_screen_pphotochange,
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context).profile_screen_swworng,
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                });
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: CachedNetworkImageProvider(
                              authView.customer!.customerImage!,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          authView.customer!.nameSurname,
                            style: theme
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold)
                        ),
                        Text(
                          authView.customer!.email,
                            style: theme
                                .textTheme
                                .bodyMedium!
                        ),
                        Text(
                          authView.customer!.phone,
                            style: theme
                                .textTheme
                                .bodyMedium!
                        ),
                        Text(
                            "${AppLocalizations.of(context).profile_screen_memberdate} : ${DateFormat('dd MMM yy').format(authView.customer!.createdAt!)}",
                            style: TextStyle(
                                color: theme.colorScheme.onBackground
                                    .withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              const Divider(),
              ProfileListTile(
                key: Key("notifications"),
                title: AppLocalizations.of(context).profile_screen_notifications,
                icon: MdiIcons.bellRingOutline,
                onTap: NotificationScreen(),
              ),
              const Divider(),
              ProfileListTile(
                key: Key("credit"),
                title: AppLocalizations.of(context).profile_screen_payment,
                icon: MdiIcons.creditCardOutline,
                onTap: PaymentMethodsScreen(isFromPayment: false,),
              ),
              const Divider(),
              ProfileListTile(

                title: AppLocalizations.of(context).profile_screen_parkhistory,
                icon: MdiIcons.history,
                subtitle: 'history',
                onTap: HistoryScreen(),
              ),
              const Divider(),
              ProfileListTile(
                subtitle: 'campaign',
                title: AppLocalizations.of(context).profile_screen_campaigns,
                icon: Icons.campaign_outlined,
                onTap: CampaignScreen(),
              ),
              const Divider(),
              ProfileListTile(
               // key: Key("coupons"),

                title: AppLocalizations.of(context).profile_screen_couponcodes,
                subtitle: 'coupons',
                icon: MdiIcons.ticketOutline,
                onTap: CouponScreen(),
              ),
              /*const Divider(),
              ProfileListTile(

                title: AppLocalizations.of(context).profile_screen_invcode,
                icon: MdiIcons.tagOutline,
                onTap: LoginScreen(),
                subtitle: AppLocalizations.of(context).profile_screen_comingsoon,
              ),
              const Divider(),
              ProfileListTile(
                key: Key("profilesettings"),
                title: AppLocalizations.of(context).profile_screen_settings,
                icon: Icons.settings_outlined,
                onTap: SettingsScreen(),
                subtitle: AppLocalizations.of(context).profile_screen_comingsoon,
              ),*/
              const Divider(),
              ProfileListTile(
                key: Key("other"),
                title: AppLocalizations.of(context).profile_screen_other,
                icon: MdiIcons.paperclip,
                onTap: OtherScreen(),
              ),
              /*const Divider(),
              ProfileListTile(
                key: Key("support"),
                title: AppLocalizations.of(context).profile_screen_sup,
                icon: MdiIcons.faceAgent,
                onTap: SupportChatScreen(),
              ),*/
              const Divider(),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text(
                              AppLocalizations.of(context).profile_screen_logoutsure,
                            ),
                            authView.authProcess == AuthProcess.idle
                                ? Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            authView.signOut();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            AppLocalizations.of(context).profile_screen_yes,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child:  Text(
                                            AppLocalizations.of(context).profile_screen_no,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(MdiIcons.logout,
                          size: 22, color: theme.colorScheme.error),
                      const SizedBox(width: 16),
                       Expanded(
                        child: Text(
                          AppLocalizations.of(context).profile_screen_logout,
                          style: TextStyle(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                      Icon(MdiIcons.chevronRight,
                          size: 22, color: theme.colorScheme.onBackground),
                    ],
                  ),
                ),
              ),
              const Divider(),
            ],
          )
        ],
      ),
    );
  }
}
