import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/enum.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/ui/screen/main/vendor_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NearParkListItem extends StatelessWidget {
  final VendorModel vendor;

  const NearParkListItem({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VendorDetailScreen(vendor: vendor),
            ),
          );
        },
        child: Container(
          height: 96,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: vendor.imgList.length != 0
                      ? vendor.imgList[0]
                      : "https://firebasestorage.googleapis.com/v0/b/heryerpark-ms.appspot.com/o/vendorImage%2Fdefaultpark.jpg?alt=media&token=e156a34e-2bfe-4f7b-a240-1f827e43ef57",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 4.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendor.parkName,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      vendor.address,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .color!
                                .withOpacity(0.5),
                          ),
                    ),
                    SizedBox(
                      height: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .fontSize,
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            calculateDensity(vendor.density),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                          Text(
                            "${vendor.distance!.toStringAsFixed(2)} km",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Card(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: Theme.of(context).textTheme.titleMedium!.fontSize,
                        ),
                        Text(
                          vendor.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
