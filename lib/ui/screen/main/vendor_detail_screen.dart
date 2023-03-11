import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer/core/model/enum.dart';
import 'package:customer/core/model/rate_model.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/comments_widget.dart';
import 'package:customer/ui/screen/main/all_comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VendorDetailScreen extends StatelessWidget {
  final VendorModel vendor;
  const VendorDetailScreen({Key? key, required this.vendor}) : super(key: key);

  Widget createSlider() {
    final List<Widget> imageSliders = vendor.imgList
        .map(
          (model) => SizedBox(
            width: double.maxFinite,
            child: CachedNetworkImage(
              imageUrl: model,
              fit: BoxFit.cover,
            ),
          ),
        )
        .toList();

    return CarouselSlider(
      items: imageSliders,
      carouselController: CarouselController(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
      ),
    );
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            createSlider(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            vendor.parkName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${AppLocalizations.of(context).vendor_detail_screen_density}: ${calculateDensity(vendor.density,context)}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                              "${AppLocalizations.of(context).vendor_detail_screen_work_hours}: ${vendor.openTime} - ${vendor.closeTime}"),
                        ],
                      ),
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
                                  vendor.rating.toStringAsFixed(1),
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
                    ]),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "${vendor.address} - ${vendor.distance!.toStringAsFixed(2)} km",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 3,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        MdiIcons.directions,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
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
                      AppLocalizations.of(context).vendor_detail_screen_park_settings,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 64,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                AppLocalizations.of(context).vendor_detail_screen_multi_storey_car_park,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Katlı Otopark",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Katlı Otopark",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Katlı Otopark",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Katlı Otopark",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Katlı Otopark",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Katlı Otopark",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.car_repair,
                                size: 32,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Katlı Otopark",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).payment_screen_price_list,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Divider(),
                          ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == vendor.price.length - 1) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "${vendor.price[index]["timeRange"][0]}+ ${AppLocalizations.of(context).payment_screen_hours}"),
                                      Text(
                                        "${vendor.price[index]["price"]} ₺",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  );
                                }
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${vendor.price[index]["timeRange"][0]} - ${vendor.price[index]["timeRange"][1]} ${AppLocalizations.of(context).payment_screen_hours}"),
                                    Text(
                                      "${vendor.price[index]["price"]} ₺",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              },
                              itemCount: vendor.price.length),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).rate_screen_rate,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context).rate_screen_security}: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                          Row(
                                            children: [
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
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context).rate_screen_service_quality}: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                          Row(
                                            children: [
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
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context).rate_screen_accessibility}: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!,
                                          ),
                                          Row(
                                            children: [
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
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Divider(),
                    FutureBuilder(
                        future:
                            authView.getVendorComments(vendor.vendorId, false),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data is List<RateModel>) {
                              List<RateModel> rateList =
                                  snapshot.data as List<RateModel>;
                              if (rateList.isNotEmpty) {
                                return ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    primary: false,
                                    itemCount: rateList.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return CommentsWidget(
                                          rateModel: rateList[i]);
                                    });
                              } else {
                                return Center(
                                  child: Text(AppLocalizations.of(context).all_commend_screen_nocom),
                                );
                              }
                            } else {
                              return Center(
                                child: Text(AppLocalizations.of(context).all_commend_screen_nocom),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                    const Divider(),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllCommentsScreen(
                                vendorId: vendor.vendorId,
                              ),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context).vendor_detail_screen_show_all_commends),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
