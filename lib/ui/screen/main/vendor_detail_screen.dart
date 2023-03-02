import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(vendor.parkName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          createSlider(),
        ],
      ),
    );
  }
}
