class PayModel {
  final double price;
  final String cardUserKey;
  final String cardToken;
  final String uid;
  final String name;
  final String surname;
  final String gsmNumber;
  final String email;
  final String identityNumber;
  final String address;
  String? ip;
  final double density;
  final String city;
  final String country;
  final String requestId;
  final String vendorId;
  String? couponId;
  double? couponPrice;

  PayModel(
      {required this.price,
      required this.cardUserKey,
      required this.cardToken,
      required this.uid,
      required this.name,
      required this.surname,
      required this.gsmNumber,
      required this.email,
      required this.identityNumber,
      required this.address,
      this.ip,
      required this.density,
      required this.city,
      required this.country,
      required this.requestId,
      required this.vendorId,
      this.couponId,
      this.couponPrice});

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "cardUserKey": cardUserKey,
      "cardToken": cardToken,
      "uid": uid,
      "name": name,
      "surname": surname,
      "gsmNumber": gsmNumber,
      "email": email,
      "identityNumber": identityNumber,
      "address": address,
      "ip": ip,
      "city": city,
      "country": country,
      "requestId": requestId,
      "vendorId": vendorId,
      "couponId": couponId,
      "couponPrice": couponPrice,
      "density": density,

    };
  }
}
