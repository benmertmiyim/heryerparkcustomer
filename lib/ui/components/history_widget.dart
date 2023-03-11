import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/enum.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/ui/screen/main/rate_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryWidget extends StatelessWidget {
  final ParkHistory parkHistory;
  final bool isMainScreen;

  const HistoryWidget(
      {Key? key, required this.parkHistory, required this.isMainScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parkHistory.parkName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      DateFormat('dd MMM yy - kk:mm')
                          .format(parkHistory.requestTime),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).status,
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .color!
                            .withOpacity(0.5),
                      ),
                    ),
                    Text(
                      statusToString(parkHistory.status,context),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: parkHistory.status == StatusEnum.denied
                            ? Colors.red
                            : (parkHistory.status == StatusEnum.process
                                ? Colors.orange
                                : Colors.green),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(
                    parkHistory.employeeImage,
                  ),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).request_screen_employee,
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .color!
                            .withOpacity(0.5),
                      ),
                    ),
                    Text(
                      parkHistory.employeeNameSurname,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            parkHistory.status == StatusEnum.completed || isMainScreen
                ? Column(
                    children: [
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context).payment_screen_total_price,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color!
                                      .withOpacity(0.5),
                                ),
                              ),
                              Text(
                                "${parkHistory.totalPrice} ₺",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context).payment_screen_total_duration,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color!
                                      .withOpacity(0.5),
                                ),
                              ),
                              Text(
                                "${parkHistory.totalMins!.toStringAsFixed(0)} ${AppLocalizations.of(context).payment_screen_total_mins}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            parkHistory.status == StatusEnum.completed && !parkHistory.rated!
                ? Column(
                    children: [
                      const Divider(),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RateScreen(
                                  parkHistory: parkHistory,
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
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
