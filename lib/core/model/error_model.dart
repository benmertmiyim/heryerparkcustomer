import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorModel {
  final String status;
  final int errorCode;
  final String message;
  final DateTime systemTime;

  ErrorModel({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.systemTime,
  });

  ErrorModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        errorCode = json['errorCode'],
        message = json['message'],
        systemTime = (json['systemTime'] as Timestamp).toDate();
}
