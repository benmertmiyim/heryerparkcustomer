import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/history_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveParkWidget extends StatelessWidget {
  const ActiveParkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    if (authView.processParks.isNotEmpty) {
      ParkHistory processPark = authView.processParks.first;
      DateTime now = DateTime.now();
      DateTime requestDate = processPark.requestTime;
      Duration duration = now.difference(requestDate);
      processPark.totalMins = duration.inMinutes.toDouble();

      for (int i = 0; i < processPark.price.length; i++) {
        if (i == processPark.price.length - 1) {
          processPark.totalPrice = processPark.price[i]["price"].toDouble();
          break;
        } else {
          if (processPark.price[i]["timeRange"][0] <= duration.inHours &&
              duration.inHours < processPark.price[i]["timeRange"][1]) {
            processPark.totalPrice = processPark.price[i]["price"].toDouble();
            break;
          }
        }
      }

      return HistoryWidget(
        parkHistory: processPark,
        isMainScreen: true,
      );
    } else {
      return Container();
    }
  }
}
