import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/locator.dart';
import 'package:customer/ui/components/near_park_list_item.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class NearVendorListScreen extends StatelessWidget {
  const NearVendorListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocationView locationView = Provider.of<LocationView>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Near Vendor List"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(MdiIcons.filterVariant))
        ],
      ),
      body: FutureBuilder(
          future: locator<AuthService>().getNearVendor(
              locationView.currentPosition!.latitude,
              locationView.currentPosition!.longitude,
              0.5,
              null),
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
                  return ListView.builder(
                    itemCount: vendorList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return NearParkListItem(vendor: vendorList[i]);
                    },
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
          }),
    );
  }
}
