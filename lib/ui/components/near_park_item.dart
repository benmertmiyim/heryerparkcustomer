import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/enum.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/ui/screen/main/vendor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NearParkItem extends StatelessWidget {
  final VendorModel vendor;

  const NearParkItem({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
          child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VendorDetailScreen(vendor: vendor),
            ),
          );
        },
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: vendor.imgList.length != 0
                    ? vendor.imgList[0]
                    : "https://firebasestorage.googleapis.com/v0/b/heryerpark-ms.appspot.com/o/vendorImage%2Fdefaultpark.jpg?alt=media&token=e156a34e-2bfe-4f7b-a240-1f827e43ef57",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              vendor.parkName,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontSize,
                              ),
                              Text(
                                vendor.rating.toStringAsFixed(1),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: SizedBox(
                        height:
                            Theme.of(context).textTheme.titleLarge!.fontSize,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Icon(
                              Icons.car_repair,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                            Icon(
                              MdiIcons.carParkingLights,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                            Icon(
                              MdiIcons.carBattery,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                            Icon(
                              Icons.add,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                            Icon(
                              Icons.car_repair,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                            Icon(
                              MdiIcons.carParkingLights,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                            Icon(
                              MdiIcons.carBattery,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                            Icon(
                              Icons.add,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .fontSize,
                            ),
                            const VerticalDivider(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            calculateDensity(vendor.density),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            "${vendor.distance!.toStringAsFixed(2)} km",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
