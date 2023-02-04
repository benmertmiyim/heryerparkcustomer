import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatelessWidget {
  final ParkHistory parkHistory;

  const RequestScreen({Key? key, required this.parkHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    AuthView authView = Provider.of<AuthView>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "HerYer",
              style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontStyle: FontStyle.italic),
            ),
            TextSpan(
              text: "Park",
              style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: CachedNetworkImageProvider(
                          parkHistory.employeeImage,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        parkHistory.employeeNameSurname,
                      )
                    ],
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
                          parkHistory.parkName,
                        ),
                        Text(
                          "Start Time: ${DateFormat('dd MMM yy kk:mm').format(parkHistory.requestTime)}",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("Price List"),
            ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == parkHistory.price.length - 1) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${parkHistory.price[index]["timeRange"][0]}+ hours"),
                        Text("${parkHistory.price[index]["price"]} ₺"),
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${parkHistory.price[index]["timeRange"][0]} - ${parkHistory.price[index]["timeRange"][1]} hours"),
                      Text("${parkHistory.price[index]["price"]} ₺"),
                    ],
                  );
                },
                itemCount: parkHistory.price.length),
            const SizedBox(
              height: 16,
            ),
            authView.authProcess == AuthProcess.busy
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            authView
                                .replyRequest(
                                    parkHistory.vendorId,
                                    parkHistory.customerId,
                                    parkHistory.requestId,
                                    true)
                                .then((value) {
                              if (value is Map) {
                                if (value["status"] == "error") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        value["message"],
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value.toString(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary),
                          child: const Text("Accept"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            authView
                                .replyRequest(
                                    parkHistory.vendorId,
                                    parkHistory.customerId,
                                    parkHistory.requestId,
                                    false)
                                .then((value) {
                              if (value is Map) {
                                if (value["status"] == "error") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        value["message"],
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value.toString(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.error),
                          child: const Text("Rejection"),
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
