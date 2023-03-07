import 'package:cloud_firestore/cloud_firestore.dart';

class RateModel {
  double security;
  double serviceQuality;
  double accessibility;
  String message;
  String customerId;
  String vendorId;
  String processId;
  DateTime? rateDate;

  RateModel(
      {required this.security,
        required this.serviceQuality,
        required this.accessibility,
        required this.customerId,
        required this.vendorId,
        this.rateDate,
        required this.processId,
        required this.message});

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      security: json["security"].toDouble(),
      serviceQuality: json["serviceQuality"].toDouble(),
      accessibility: json["accessibility"].toDouble(),
      message: json["comment"],
      customerId: json["customerId"],
      vendorId: json["vendorId"],
      rateDate: json["commentDate"] != null ? (json["commentDate"] as Timestamp).toDate() : null,
      processId: json["requestId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "security": this.security,
      "serviceQuality": this.serviceQuality,
      "accessibility": this.accessibility,
      "comment": this.message,
      "customerId": this.customerId,
      "vendorId": this.vendorId,
      "requestId": this.processId,
    };
  }

}