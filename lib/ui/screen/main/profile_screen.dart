import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/profile_list_tile.dart';
import 'package:customer/ui/screen/auth/login_screen.dart';
import 'package:customer/ui/screen/main/campaing_screen.dart';
import 'package:customer/ui/screen/main/coupon_screen.dart';
import 'package:customer/ui/screen/main/notification_screen.dart';
import 'package:customer/ui/screen/main/other_screen.dart';
import 'package:customer/ui/screen/main/settings_screen.dart';
import 'package:customer/ui/screen/main/support_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

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
                                  if (value != "Something went wrong") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Profile photo changed successfully",
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Something went wrong",
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
                        ),
                        Text(
                          authView.customer!.email,
                        ),
                        Text(
                          authView.customer!.phone,
                        ),
                        Text(
                          "Membership date: ${DateFormat('dd MMM yy').format(authView.customer!.createdAt!)}",
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
              const ProfileListTile(
                title: "Notifications",
                icon: MdiIcons.bellRingOutline,
                onTap: NotificationScreen(),
              ),
              const Divider(),
              const ProfileListTile(
                title: "Payment Methods",
                icon: MdiIcons.creditCardOutline,
                onTap: LoginScreen(),
                subtitle: "Coming soon !",
              ),
              const Divider(),
              const ProfileListTile(
                title: "Park History",
                icon: MdiIcons.history,
                onTap: LoginScreen(),
                subtitle: "Coming soon !",
              ),
              const Divider(),
              const ProfileListTile(
                title: "Campaigns",
                icon: Icons.campaign_outlined,
                onTap: CampaignScreen(),
              ),
              const Divider(),
              const ProfileListTile(
                title: "Coupon Codes",
                icon: MdiIcons.ticketOutline,
                onTap: CouponScreen(),
              ),
              const Divider(),
              const ProfileListTile(
                title: "Invite Your Friends",
                icon: MdiIcons.tagOutline,
                onTap: LoginScreen(),
                subtitle: "Coming soon !",
              ),
              const Divider(),
              const ProfileListTile(
                title: "Settings",
                icon: Icons.settings_outlined,
                onTap: SettingsScreen(),
                subtitle: "Coming soon !",
              ),
              const Divider(),
              const ProfileListTile(
                title: "Other",
                icon: MdiIcons.paperclip,
                onTap: OtherScreen(),
              ),
              const Divider(),
              const ProfileListTile(
                title: "Support",
                icon: MdiIcons.faceAgent,
                onTap: SupportChatScreen(),
              ),
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
                            const Text(
                              "Are you sure you want to logout?",
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
                                          child: const Text(
                                            "Yes",
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "No",
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
                      const Expanded(
                        child: Text(
                          "Logout",
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
