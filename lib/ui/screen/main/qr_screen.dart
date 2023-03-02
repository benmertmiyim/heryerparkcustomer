import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/active_park_widget.dart';
import 'package:customer/ui/components/code_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    ThemeData theme = Theme.of(context);

    if (authView.authProcess == AuthProcess.busy) {
      return const CircularProgressIndicator();
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(
                data: authView.processParks.isNotEmpty
                    ? authView.processParks[0].requestId
                    : "${authView.customer!.code!}-${authView.customer!.uid}",
                version: QrVersions.auto,
                foregroundColor: theme.colorScheme.onBackground,
              ),
              Text(
                authView.processParks.isNotEmpty
                    ? authView.processParks[0].requestId
                    : "${authView.customer!.code!}-${authView.customer!.uid}",
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .color!
                      .withOpacity(0.5),
                ),
              ),
              Text(
                authView.customer!.nameSurname,
                style: theme.textTheme.headline6,
              ),
              const SizedBox(
                height: 16,
              ),
              authView.processParks.isNotEmpty
                  ? const ActiveParkWidget()
                  : const CodeTimerWidget(),
            ],
          ),
        ),
      );
    }
  }
}
