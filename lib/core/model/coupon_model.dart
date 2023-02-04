import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel{
  final String id;
  final String title;
  final String description;
  final String code;
  final double price;
  final DateTime validDate;
  final bool used;

  CouponModel({
    required this.id,
    required this.used,
    required this.title,
    required this.code,
    required this.description,
    required this.price,
    required this.validDate,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      title: json['title'],
      code: json['code'],
      used: json['used'] as bool,
      description: json['description'],
      price: json['price'].toDouble(),
      validDate: (json['validDate'] as Timestamp).toDate(),
    );
  }

}