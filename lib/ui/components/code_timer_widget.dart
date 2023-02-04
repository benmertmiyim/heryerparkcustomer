import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';

class CodeTimerWidget extends StatefulWidget {
  const CodeTimerWidget({Key? key,}) : super(key: key);

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
  Widget build(BuildContext context) {
    controller =
        CountdownTimerController(endTime: authView.customer!.codeTime!.millisecondsSinceEpoch ,);
    controller.start();
    return CountdownTimer(
      controller: controller,
      widgetBuilder: (_, CurrentRemainingTime? time)  {
        if(time == null){
          authView.generateCode();
        }
        return Text(
          '${time?.min ?? ""}${time?.min != null ? ":": ""}${time?.sec ?? 0} sec left for generate new code',
        );
      },
    );
  }
}