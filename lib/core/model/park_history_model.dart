import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/enum.dart';

class ParkHistory {
  final DateTime requestTime;
  DateTime? closedTime;
  DateTime? replyTime;
  final String vendorId;
  final String requestId;
  final String customerName;
  final String customerImage;
  final String customerId;
  final String employeeId;
  final String employeeNameSurname;
  final String employeeImage;
  final String parkName;
  String? paymentId;
  bool? rated;
  String? closedReason;
  final List price;
  double? totalMins;
  double? totalPrice;
  StatusEnum status;
  double? density;

  ParkHistory({
    required this.requestTime,
    required this.vendorId,
    required this.requestId,
    required this.customerName,
    required this.customerImage,
    required this.customerId,
    required this.employeeId,
    required this.employeeNameSurname,
    required this.employeeImage,
    required this.parkName,
    required this.price,
    required this.status,
    required this.rated,
    this.density,
    this.closedTime,
    this.replyTime,
    this.paymentId,
    this.totalMins,
    this.totalPrice,
    this.closedReason,
  });

  factory ParkHistory.fromJson(Map<String, dynamic> json) {
    return ParkHistory(
      requestTime: (json["requestTime"] as Timestamp).toDate(),
      closedTime: json["closedTime"] != null
          ? (json["closedTime"] as Timestamp).toDate()
          : null,
      replyTime: json["replyTime"] != null
          ? (json["replyTime"] as Timestamp).toDate()
          : null,
      vendorId: json["vendorId"],
      rated: json["rated"] != null ? json["rated"] : null,
      requestId: json["requestId"],
      density: json["density"] != null ? json["density"].toDouble() : null,
      customerName: json["customerName"],
      customerImage: json["customerImage"] != null ? json["customerImage"] : "",
      customerId: json["customerId"],
      employeeId: json["employeeId"],
      employeeNameSurname: json["employeeNameSurname"],
      employeeImage:
          "https://firebasestorage.googleapis.com/v0/b/heryerpark-ms.appspot.com/o/customerImage%2Fdefault_avatar.jpeg?alt=media&token=a76a5883-df23-4f13-93b1-f45b485ad2ad",
      parkName: json["parkName"],
      paymentId: json["paymentId"] != null ? json["paymentId"] : null,
      closedReason: json["closedReason"] != null ? json["closedReason"] : null,
      price: json["price"] as List,
      totalMins:
          json["totalMins"] != null ? json["totalMins"].toDouble() : null,
      totalPrice:
          json["totalPrice"] != null ? json["totalPrice"].toDouble() : null,
      status: statusFromString(json["status"]),
    );
  }
}
