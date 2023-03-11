import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/history_widget.dart';
import 'package:customer/ui/screen/main/rate_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    if(authView.parkHistory.isNotEmpty){
      ParkHistory? ratePark;
      for (var element in authView.parkHistory) {
        ParkHistory parkHistory = element;
        if(parkHistory.rated == false){
          ratePark = element;
          break;
        }
      }

      if(ratePark != null){
        return Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).rate_widget_forget,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ratePark.parkName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          DateFormat('dd MMM yy - kk:mm')
                              .format(ratePark.requestTime),
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .color!
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RateScreen(
                              parkHistory: ratePark!,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            MdiIcons.star,
                            size: 16,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(AppLocalizations.of(context).rate_screen_send),
                        ],
                      ),
                    )                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    }
    return Container();
  }
}
