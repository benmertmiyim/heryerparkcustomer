import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  final String id;
  final bool active;
  final String bannerURL;
  final DateTime addedDate;
  final DateTime validationDate;

  BannerModel({
    required this.id,
    required this.active,
    required this.bannerURL,
    required this.addedDate,
    required this.validationDate,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      active: json['active'],
      bannerURL: json['bannerURL'],
      addedDate: (json['addedDate'] as Timestamp).toDate(),
      validationDate: (json['validationDate'] as Timestamp).toDate(),
    );
  }
}