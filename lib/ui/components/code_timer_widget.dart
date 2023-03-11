import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CodeTimerWidget extends StatefulWidget {
  const CodeTimerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CodeTimerWidget> createState() => _CodeTimerWidgetState();
}

class _CodeTimerWidgetState extends State<CodeTimerWidget> {
  late CountdownTimerController controller;
  late AuthView authView;

  @override
  void initState() {
    authView = Provider.of<AuthView>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  void activate() {
    super.activate();
    controller.start();
  }

  @override
  void reassemble() {
    super.reassemble();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    controller = CountdownTimerController(
      endTime: authView.customer!.codeTime!.millisecondsSinceEpoch,
    );
    controller.start();
    return CountdownTimer(
      controller: controller,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          authView.generateCode();
        }
        return Text(
          '${time?.min ?? ""}${time?.min != null ? ":" : ""}${time?.sec ?? 0} ${AppLocalizations.of(context).qr_screen_time}',
          style: TextStyle(
            color:
                Theme.of(context).textTheme.titleSmall!.color!.withOpacity(0.5),
          ),
        );
      },
    );
  }
}
