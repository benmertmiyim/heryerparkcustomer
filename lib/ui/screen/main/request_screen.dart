import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/core/service/auth_service.dart';
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
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: AuthService().getVendor(parkHistory.vendorId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data is VendorModel) {
                          VendorModel vendor = snapshot.data as VendorModel;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parkHistory.parkName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const Divider(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                        color: Colors.green,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .fontSize,
                                              ),
                                              Text(
                                                vendor.rating
                                                    .toStringAsFixed(1),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Security: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!,
                                            ),
                                            Text(
                                              vendor.security
                                                  .toStringAsFixed(1),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .color,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Service Quality: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!,
                                            ),
                                            Text(
                                              vendor.serviceQuality
                                                  .toStringAsFixed(1),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .color,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Accessibility: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!,
                                            ),
                                            Text(
                                              vendor.accessibility
                                                  .toStringAsFixed(1),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .color,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text("No data"),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Information",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: CachedNetworkImageProvider(
                            parkHistory.employeeImage,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(width: 8,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Employee: ${parkHistory.employeeNameSurname}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!,
                            ),
                            Text(
                              "Start Time: ${DateFormat('dd MMM yy kk:mm').format(parkHistory.requestTime)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!,
                            ),
                            Text(
                              "Price Type: Hourly",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Price List",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
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
                                Text("${parkHistory.price[index]["price"]} ₺",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                              ],
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${parkHistory.price[index]["timeRange"][0]} - ${parkHistory.price[index]["timeRange"][1]} hours"),
                              Text("${parkHistory.price[index]["price"]} ₺",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                            ],
                          );
                        },
                        itemCount: parkHistory.price.length),
                  ],
                ),
              ),
            ),
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
