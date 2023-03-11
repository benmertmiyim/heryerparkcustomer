import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/rate_model.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RateScreen extends StatefulWidget {
  const RateScreen({Key? key, required this.parkHistory}) : super(key: key);
  final ParkHistory parkHistory;

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  double security = 5;
  double serviceQuality = 5;
  double accessibility = 5;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parkHistory.parkName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: AuthService().getVendor(widget.parkHistory.vendorId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.data is VendorModel) {
                            VendorModel vendor = snapshot.data as VendorModel;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.parkHistory.parkName,
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
                                                      .titleLarge!.fontSize,
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
                                                "${AppLocalizations.of(context).rate_screen_security}: ",
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
                                                "${AppLocalizations.of(context).rate_screen_service_quality}: ",
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
                                                "${AppLocalizations.of(context).rate_screen_accessibility}: ",
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

                          }
                          else {
                            return Center(
                              child: Text(AppLocalizations.of(context).near_vendor_list_screen_no),
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
                        AppLocalizations.of(context).rate_screen_rate,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Text(AppLocalizations.of(context).rate_screen_security),
                      RatingBar.builder(
                          initialRating: security,
                          itemCount: 5,
                          maxRating: 5,
                          itemBuilder: (index, color) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 32,
                              ),
                          onRatingUpdate: (v) {
                            //
                            setState(() {
                              security = v;
                            });
                          }),
                      Text(
                        AppLocalizations.of(context).rate_screen_service_quality,
                      ),
                      RatingBar.builder(
                          initialRating: serviceQuality,
                          itemCount: 5,
                          maxRating: 5,
                          itemBuilder: (index, color) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 32,
                              ),
                          onRatingUpdate: (v) {
                            //
                            setState(() {
                              serviceQuality = v;
                            });
                          }),
                      Text(
                        AppLocalizations.of(context).rate_screen_accessibility,
                      ),
                      RatingBar.builder(
                          initialRating: accessibility,
                          itemCount: 5,
                          maxRating: 5,
                          itemBuilder: (index, color) => const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 32,
                              ),
                          onRatingUpdate: (v) {
                            //
                            setState(() {
                              accessibility = v;
                            });
                          }),
                    ],
                  ),
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
                        AppLocalizations.of(context).rate_screen_comment,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      TextField(
                        controller: myController,
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: null,
                        maxLength: 250,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "${AppLocalizations.of(context).rate_screen_you_can_comment}",
                          contentPadding: EdgeInsets.all(8),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Consumer<AuthView>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.authProcess == AuthProcess.idle) {
                    return SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () async {
                          RateModel rateModel = RateModel(
                              security: security,
                              serviceQuality: serviceQuality,
                              accessibility: accessibility,
                              customerId: widget.parkHistory.customerId,
                              vendorId: widget.parkHistory.vendorId,
                              processId: widget.parkHistory.requestId,
                              message: myController.text);
                          value.ratePark(rateModel).then((value) {
                            if (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context).rate_screen_rate_success,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context).rate_screen_rate_failed,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Text(AppLocalizations.of(context).rate_screen_send),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
