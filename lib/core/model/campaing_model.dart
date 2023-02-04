import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignModel{
  final String id;
  final String title;
  final String description;
  final String imageURL;
  final DateTime addedDate;
  final DateTime validationDate;

  CampaignModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.addedDate,
    required this.validationDate,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageURL: json['imageURL'],
      addedDate: (json['addedDate'] as Timestamp).toDate(),
      validationDate: (json['validationDate'] as Timestamp).toDate(),
    );
  }
}