class VendorModel {
  double security;
  double serviceQuality;
  double accessibility;
  double rating;
  final bool active;
  final String address;
  final String closeTime;
  final String openTime;
  final List imgList;
  final double latitude;
  final double longitude;
  final String parkName;
  final List price;
  final String vendorId;
  final double? density;
  final double? distance;

  VendorModel(
      {required this.active,
      required this.address,
      required this.closeTime,
      required this.openTime,
      required this.imgList,
      required this.latitude,
      required this.longitude,
      required this.parkName,
      required this.price,
      required this.vendorId,
      required this.security,
      required this.serviceQuality,
      required this.accessibility,
      required this.rating,
      required this.distance,
      required this.density});

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      security: json["security"].toDouble(),
      serviceQuality: json["serviceQuality"].toDouble(),
      accessibility: json["accessibility"].toDouble(),
      rating: json["rating"].toDouble(),
      active: json["active"] as bool,
      address: json["address"],
      closeTime: json["closeTime"],
      openTime: json["openTime"],
      density: json["density"] != null ? json["density"].toDouble() : null,
      imgList: json["imgList"] as List,
      latitude: json["latitude"].toDouble(),
      longitude: json["longitude"].toDouble(),
      parkName: json["parkName"],
      distance: json["distance"] != null ? json["distance"].toDouble() : null,
      price: json["price"] as List,
      vendorId: json["vendorId"],
    );
  }

}
