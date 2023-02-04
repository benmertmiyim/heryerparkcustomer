import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String uid;
  final String email;
  final String nameSurname;
  final String phone;
  DateTime? createdAt;
  int? code;
  DateTime? codeTime;
  String? cardUserKey;
  String? customerImage;
  bool? verified;

  CustomerModel({
    required this.uid,
    required this.email,
    required this.nameSurname,
    required this.phone,
    this.createdAt,
    this.code,
    this.codeTime,
    this.cardUserKey,
    this.customerImage,
    this.verified,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      uid: json["uid"],
      email: json["email"],
      nameSurname: json["nameSurname"],
      phone: json["phone"],
      createdAt: json["createdAt"] != null ? (json["createdAt"] as Timestamp).toDate() : DateTime.now(),
      code: json["code"] != null ? json["code"] : null,
      codeTime: json["codeTime"] != null ? (json["codeTime"] as Timestamp).toDate() : null,
      cardUserKey: json["cardUserKey"] != null ? json["cardUserKey"] : null,
      customerImage: json["customerImage"] != null ? json["customerImage"] : "https://firebasestorage.googleapis.com/v0/b/heryerpark-ms.appspot.com/o/customerImage%2Fdefault_avatar.jpeg?alt=media&token=a76a5883-df23-4f13-93b1-f45b485ad2ad",
      verified: json["verified"] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": this.uid,
      "email": this.email,
      "nameSurname": this.nameSurname,
      "phone": this.phone,
      "createdAt": this.createdAt,
      "code": this.code,
      "codeTime": this.codeTime,
      "cardUserKey": this.cardUserKey,
      "customerImage": this.customerImage,
      "verified": this.verified,
    };
  }

  @override
  String toString() {
    return 'CustomerModel{uid: $uid, email: $email, nameSurname: $nameSurname, phone: $phone, createdAt: $createdAt, code: $code, codeTime: $codeTime, cardUserKey: $cardUserKey, customerImage: $customerImage, verified: $verified}';
  }
}
