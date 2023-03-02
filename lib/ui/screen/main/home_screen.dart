import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/active_park_widget.dart';
import 'package:customer/ui/components/history_widget.dart';
import 'package:customer/ui/components/near_parks_widget.dart';
import 'package:customer/ui/components/rate_widget.dart';
import 'package:customer/ui/components/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SliderWidget(),
        const SizedBox(height: 8,),
        const NearParksWidget(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ActiveParkWidget(),
              RateWidget(),
            ],
          ),
        )
      ],
    );
  }
}
