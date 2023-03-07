import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/locator.dart';
import 'package:customer/ui/components/near_park_item.dart';
import 'package:customer/ui/screen/main/near_vendor_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NearParksWidget extends StatelessWidget {
  const NearParksWidget({Key? key}) : super(key: key);

  Widget _buildNearParkItem(Widget content) {
    return SizedBox(
      height: 256,
      child: content,
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    LocationView locationView = Provider.of<LocationView>(context);

    if (authView.processParks.isEmpty) {
      if (locationView.currentPosition != null) {
        return _buildNearParkItem(FutureBuilder(
            future: locator<AuthService>().getNearVendor(
                locationView.currentPosition!.latitude,
                locationView.currentPosition!.longitude,
                0.5,
                5),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data is List) {
                  if (snapshot.data!.isNotEmpty) {
                    List<VendorModel> vendorList =
                        snapshot.data as List<VendorModel>;
                    AuthView authView = Provider.of<AuthView>(context);
                    authView.nearVendors = vendorList;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Near Parks",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const NearVendorListScreen(),
                                    ),
                                  );
                                },
                                child: const Text("See All"),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: vendorList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return NearParkItem(
                                vendor: vendorList[i],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              } else {
                return const Center(
                  child: Text("No Data"),
                );
              }
            }));
      } else if (locationView.permission == true &&
          locationView.currentPosition == null) {
        return _buildNearParkItem(const Center(
          child: CircularProgressIndicator(),
        ));
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}
