import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/coupon_model.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/model/iyzico/pay_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/payment_card_widget.dart';
import 'package:customer/ui/screen/main/payment_methods_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  final ParkHistory parkHistory;

  const PaymentScreen({Key? key, required this.parkHistory}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool threeDSecure = false;
  double density = 5;
  double price = 0;
  CouponModel? selectedCoupon;
  final TextEditingController couponEditController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    price = selectedCoupon != null
        ? (widget.parkHistory.totalPrice! - selectedCoupon!.price < 0
            ? 1
            : widget.parkHistory.totalPrice! - selectedCoupon!.price)
        : widget.parkHistory.totalPrice!;
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "HerYer",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontStyle: FontStyle.italic),
            ),
            TextSpan(
              text: "Park",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
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
                          Text(
                            "${DateFormat('dd MMM yy - kk:mm').format(widget.parkHistory.requestTime)} / ${DateFormat('dd MMM yy - kk:mm').format(widget.parkHistory.closedTime!)}",
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
                      const Divider(),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: CachedNetworkImageProvider(
                              widget.parkHistory.employeeImage,
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                (AppLocalizations.of(context).payment_screen_employee),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color!
                                      .withOpacity(0.5),
                                ),
                              ),
                              Text(
                                widget.parkHistory.employeeNameSurname,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    (AppLocalizations.of(context).payment_screen_total_price),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .color!
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    "${widget.parkHistory.totalPrice} ₺",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    (AppLocalizations.of(context).payment_screen_total_duration),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .color!
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                  Text(
                                    "${widget.parkHistory.totalMins!.toStringAsFixed(0)} ${AppLocalizations.of(context).payment_screen_total_mins}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Text(
                        (AppLocalizations.of(context).payment_screen_price_list),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == widget.parkHistory.price.length - 1) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${widget.parkHistory.price[index]["timeRange"][0]}+ ${AppLocalizations.of(context).payment_screen_hours}"),
                                  Text(
                                      "${widget.parkHistory.price[index]["price"]} ₺"),
                                ],
                              );
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${widget.parkHistory.price[index]["timeRange"][0]} - ${widget.parkHistory.price[index]["timeRange"][1]} ${AppLocalizations.of(context).payment_screen_hours}"),
                                Text(
                                    "${widget.parkHistory.price[index]["price"]} ₺"),
                              ],
                            );
                          },
                          itemCount: widget.parkHistory.price.length),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).payment_screen_density_status,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Text(
                          AppLocalizations.of(context).payment_screen_density_status_info),
                      const SizedBox(
                        height: 8,
                      ),
                      RatingBar.builder(
                        initialRating: density,
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          switch (i) {
                            case 0:
                              return const Icon(
                                MdiIcons.numeric1CircleOutline,
                                color: Colors.green,
                              );
                            case 1:
                              return const Icon(
                                MdiIcons.numeric2CircleOutline,
                                color: Colors.lightGreen,
                              );
                            case 2:
                              return const Icon(
                                MdiIcons.numeric3CircleOutline,
                                color: Colors.amber,
                              );
                            case 3:
                              return const Icon(
                                MdiIcons.numeric4CircleOutline,
                                color: Colors.redAccent,
                              );
                            default:
                              return const Icon(
                                MdiIcons.numeric5CircleOutline,
                                color: Colors.red,
                              );
                          }
                        },
                        onRatingUpdate: (rating) {
                          density = rating;
                        },
                      ),
                      Text(
                        AppLocalizations.of(context).payment_screen_very_crowded,
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.5),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).payment_screen_very_empty,
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).payment_screen_card_details,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      authView.selectedCard != null
                          ? Column(
                              children: [
                                PaymentCardWidget(
                                    cardResultModel: authView.selectedCard!),
                                const Divider(),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: threeDSecure,
                                        onChanged: (bool? val) {
                                          setState(() {
                                            threeDSecure = val!;
                                          });
                                        }),
                                    Text(
                                      AppLocalizations.of(context).payment_screen_pay_with_3dsecure,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : SizedBox(
                              width: double.maxFinite,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (c) =>
                                          const PaymentMethodsScreen(
                                              isFromPayment: true),
                                    ),
                                  );
                                },
                                child: Text(AppLocalizations.of(context).payment_screen_chose_payment),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).payment_screen_coupon_code,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: selectedCoupon == null
                                ? TextField(
                                    controller: couponEditController,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context).payment_screen_coupon_code,
                                      contentPadding: EdgeInsets.all(8),
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .transparent), //<-- SEE HERE
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors
                                                .transparent), //<-- SEE HERE
                                      ),
                                    ),
                                  )
                                : Text("${AppLocalizations.of(context).payment_screen_coupon}: ${selectedCoupon!.code}"),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          selectedCoupon == null
                              ? Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                if (couponEditController
                                    .text.isNotEmpty) {
                                  authView
                                      .applyCoupon(
                                      couponEditController.text)
                                      .then((value) {
                                    if (value is String) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            value,
                                          ),
                                          behavior: SnackBarBehavior
                                              .floating,
                                        ),
                                      );
                                    } else {
                                      CouponModel coupon = value as CouponModel;
                                      if(coupon.price >= price){
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              AppLocalizations.of(context).payment_screen_coupon_invalid,
                                            ),
                                            behavior: SnackBarBehavior
                                                .floating,
                                          ),
                                        );
                                      }else{
                                        setState(() {
                                          selectedCoupon = coupon;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context).payment_screen_coupon_applied),
                                            behavior: SnackBarBehavior
                                                .floating,
                                          ),
                                        );
                                      }
                                    }
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        AppLocalizations.of(context).payment_screen_please_enter_code,
                                      ),
                                      behavior:
                                      SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              child: Text(AppLocalizations.of(context).payment_screen_apply),
                            ),
                          )
                              : Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedCoupon = null;
                                });
                              },
                              child: Text(AppLocalizations.of(context).payment_screen_remove),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context).payment_screen_checkout,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            selectedCoupon != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context).payment_screen_amount}: ${widget.parkHistory.totalPrice!} ₺"),
                                      Text(
                                          "${selectedCoupon!.title}: -${selectedCoupon!.price} ₺"),
                                    ],
                                  )
                                : Container(),
                            Text("${AppLocalizations.of(context).payment_screen_total_amount}: $price ₺"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              authView.authProcess == AuthProcess.idle
                  ? SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (authView.selectedCard != null) {
                            PayModel payModel = PayModel(
                                requestId: widget.parkHistory.requestId,
                                vendorId: widget.parkHistory.vendorId,
                                price: price,
                                density: density,
                                cardUserKey: authView.customer!.cardUserKey!,
                                cardToken: authView.selectedCard!.cardToken,
                                uid: authView.customer!.uid,
                                name: authView.customer!.nameSurname,
                                surname: authView.customer!.nameSurname,
                                gsmNumber: authView.customer!.phone,
                                email: authView.customer!.email,
                                couponId: selectedCoupon?.id,
                                couponPrice: selectedCoupon?.price,
                                identityNumber: "11111111111",
                                address: "Adress",
                                city: "Izmir",
                                country: "Turkey",
                            );

                                await authView.pay(payModel).then((value) {
                              if (value is ErrorModel) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value.errorMessage,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context).profile_screen_swworng,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(context).payment_screen_please_card,
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: Text(AppLocalizations.of(context).payment_screen_pay_now),
                      ),
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
