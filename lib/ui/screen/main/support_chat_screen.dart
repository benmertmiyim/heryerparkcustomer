import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupportChatScreen extends StatelessWidget {
  const SupportChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).profile_screen_sup),
      ),
      body: SafeArea(
        child: Tawk(
          directChatLink: 'https://tawk.to/chat/63c3246347425128790d818b/1gmp4c9n0',
          visitor: TawkVisitor(
            name: authView.customer!.nameSurname,
            email: authView.customer!.email,
            uid: authView.customer!.uid,
          ),
          onLoad: () {
            debugPrint('Tawk loaded');
          },
          onLinkTap: (String url) {
            debugPrint(url);
          },
          placeholder: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
