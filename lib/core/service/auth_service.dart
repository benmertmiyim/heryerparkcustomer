import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/add_card_result_model.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/model/iyzico/get_cards_result_model.dart';
import 'package:customer/core/model/iyzico/pay_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/rate_model.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/coupon_model.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:http/http.dart' as http;

class AuthService implements AuthBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Future<Object?> getCurrentCustomer() async {
    try {
      User? user = firebaseAuth.currentUser;

      if (user != null) {
        CollectionReference customer = firebaseFirestore.collection("customer");
        DocumentSnapshot documentSnapshot = await customer.doc(user.uid).get();

        if (documentSnapshot.exists) {
          Map<String, dynamic> map =
              documentSnapshot.data() as Map<String, dynamic>;
          return CustomerModel.fromJson(map);
        } else {
          return "vendorToCustomer";
        }
      }
      return "Customer not found";
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Get Current Customer : ${e.toString()}",
      );
      return "Something went wrong";
    }
  }

  @override
  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return getCurrentCustomer();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<Object?> createUserWithEmailAndPassword(
      String email, String password, String phone, String nameSurname) async {
    try {
      CollectionReference customerRef =
          firebaseFirestore.collection("customer");
      QuerySnapshot query =
          await customerRef.where("phone", isEqualTo: phone).get();
      if (query.size == 0) {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await firebaseAuth.currentUser!.sendEmailVerification();
        await firebaseAuth.currentUser!.updateDisplayName(nameSurname);
        CollectionReference customers =
            firebaseFirestore.collection("customer");
        CustomerModel customerModel = CustomerModel(
          uid: firebaseAuth.currentUser!.uid,
          email: email,
          nameSurname: nameSurname,
          phone: phone,
          verified: false,
        );
        await customers.doc(firebaseAuth.currentUser!.uid).set(
              customerModel.toJson(),
            );
        return getCurrentCustomer();
      } else {
        return "Phone number already exists";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future<String> changeCustomerImage(File customerImage) async {
    try {
      var snapshot = await firebaseStorage
          .ref("customerImage")
          .child(firebaseAuth.currentUser!.uid)
          .putFile(customerImage);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      CollectionReference customers = firebaseFirestore.collection("customer");
      await customers.doc(firebaseAuth.currentUser!.uid).update({
        "customerImage": downloadUrl,
      });
      await firebaseAuth.currentUser!.updatePhotoURL(downloadUrl);
      return downloadUrl;
    } catch (e) {
      debugPrint(
          "AuthService - Exception - Change Customer Image : ${e.toString()}");
      return "Something went wrong";
    }
  }

  @override
  Future<List<CouponModel>> getCoupons() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("customer/${firebaseAuth.currentUser!.uid}/coupon")
          .where("used", isEqualTo: false)
          .get();
      List<CouponModel> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String, dynamic> bannerMap =
            querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(CouponModel.fromJson(bannerMap));
      }
      return list;
    } catch (e) {
      debugPrint(
        "BannerService - Exception - Get Banners : ${e.toString()}",
      );
      return [];
    }
  }

  @override
  Future<Object?> sendCode(String phone) async {
    try {
      var url = Uri.https('us-central1-heryerpark-ms.cloudfunctions.net',
          'sendVerificationCode');
      var response = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({
            'phoneNumber': phone,
            'isEmployee': false,
            'customerId': firebaseAuth.currentUser!.uid
          }));
      return response.body;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Send Code : ${e.toString()}",
      );
      return false;
    }
  }

  @override
  Future<bool> verifyCode(String code) async {
    try {
      var url = Uri.https(
          'us-central1-heryerpark-ms.cloudfunctions.net', 'verifyCode');
      var response = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({
            'verificationCode': code,
            'isEmployee': false,
            'customerId': firebaseAuth.currentUser!.uid
          }));

      if (response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Verify Code : ${e.toString()}",
      );
      return false;
    }
  }

  @override
  Future<Object?> vendorToCustomer(String email) async {
    try {
      var url = Uri.https(
          'us-central1-heryerpark-ms.cloudfunctions.net', 'vendorToCustomer');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'customerEmail': email,
        }),
      );

      if (response.statusCode == 201) {
        return getCurrentCustomer();
      }
      Map<String, dynamic> map = jsonDecode(response.body);
      return map["message"];
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Verify Code : ${e.toString()}",
      );
      return "Something went wrong";
    }
  }

  @override
  Future<Object?> generateCode() async {
    try {
      var url = Uri.https(
          'us-central1-heryerpark-ms.cloudfunctions.net', 'generateCode');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'customerId': firebaseAuth.currentUser!.uid,
        }),
      );

      Map<String, dynamic> map = jsonDecode(response.body);

      return map;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Verify Code : ${e.toString()}",
      );

      return "Something went wrong";
    }
  }

  @override
  Stream<QuerySnapshot<Object?>>? getApprovalOrPaymentOrProcess(
      String customerId) {
    return firebaseFirestore.collection("customer/$customerId/history").where(
        "status",
        whereIn: ["approval", "payment", "process"]).snapshots();
  }

  @override
  Future<Object?> replyRequest(
      String vendorId, String customerId, String requestId, bool reply) async {
    try {
      var url = Uri.https(
          'us-central1-heryerpark-ms.cloudfunctions.net', 'replyRequest');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'requestId': requestId,
          'reply': reply,
          'vendorId': vendorId,
          'customerId': customerId,
        }),
      );

      Map<String, dynamic> map = jsonDecode(response.body);

      return map;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Verify Code : ${e.toString()}",
      );
      return "Something went wrong";
    }
  }

  @override
  Future<Object?> getParkHistory(String customerId) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("customer/${firebaseAuth.currentUser!.uid}/history")
          .orderBy("requestTime", descending: true)
          .get();

      List<ParkHistory> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String, dynamic> historyMap =
            querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(
          ParkHistory.fromJson(historyMap),
        );
      }
      return list;
    } catch (e) {
      debugPrint(
        "BannerService - Exception - Get Banners : ${e.toString()}",
      );
      return [];
    }
  }

  @override
  Future<Object?> getVendor(String vendorId) async {
    try {
      var url = Uri.https(
          'us-central1-heryerpark-ms.cloudfunctions.net', 'getVendor');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'vendorId': vendorId,
        }),
      );
      Map<String, dynamic> map = jsonDecode(response.body);
      debugPrint(map.toString());
      VendorModel vendorModel = VendorModel.fromJson(map);
      return vendorModel;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - getVendor : ${e.toString()}",
      );
      return null;
    }
  }

  @override
  Future<bool> ratePark(RateModel rateModel) async {
    try {
      var url = Uri.https(
          'us-central1-heryerpark-ms.cloudfunctions.net', 'rateVendor');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(rateModel.toJson()),
      );

      Map<String, dynamic> map = jsonDecode(response.body);
      debugPrint(map.toString());
      return true;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - ratePark : ${e.toString()}",
      );
      return false;
    }
  }

  @override
  Future<List> getNearVendor(
      double latitude, double longitude, double radius, int? limit) async {
    try {
      var url = Uri.https(
          'us-central1-heryerpark-ms.cloudfunctions.net', 'getNearVendor');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'latitude': latitude,
          'longitude': longitude,
          'radius': radius,
          'limit': limit,
        }),
      );
      List list = jsonDecode(response.body);

      List<VendorModel> vendorList = [];
      for (int i = 0; i < list.length; i++) {
        Map<String, dynamic> map = list[i];
        VendorModel vendorModel = VendorModel.fromJson(map);
        vendorList.add(vendorModel);
      }
      vendorList.sort((a, b) => a.distance!.compareTo(b.distance!));
      return vendorList;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - nearParks : ${e.toString()}",
      );
      return [];
    }
  }

  @override
  Future<List> getVendorComments(String vendorId, bool detail) async {
    try {
      QuerySnapshot querySnapshot;
      if (detail) {
        querySnapshot = await firebaseFirestore
            .collection("vendor/$vendorId/rating")
            .orderBy("commentDate", descending: true)
            .get();
      } else {
        querySnapshot = await firebaseFirestore
            .collection("vendor/$vendorId/rating")
            .orderBy("commentDate", descending: true)
            .limit(3)
            .get();
      }

      List<RateModel> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String, dynamic> commentMap =
            querySnapshot.docs[i].data() as Map<String, dynamic>;

        list.add(RateModel.fromJson(commentMap));
      }
      return list;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Get Comments : ${e.toString()}",
      );
      return [];
    }
  }

  @override
  Future<Object?> addCard(AddCardModel addCardModel) async {
    try {
      var customer = await getCurrentCustomer();
      if (customer is CustomerModel) {
        var url = Uri.https(
            'us-central1-heryerpark-ms.cloudfunctions.net', 'regCard');
        var response = await http.post(
          url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(<String, String>{
            'cardUserKey': customer.cardUserKey ?? "",
            'email': customer.email,
            'cardAlias': addCardModel.cardAlias,
            'cardHolderName': addCardModel.cardHolderName,
            'cardNumber': addCardModel.cardNumber,
            'expireMonth': addCardModel.expireMonth,
            'expireYear': addCardModel.expireYear,
          }),
        );
        var result = json.decode(response.body);
        if (result["status"] == "success") {
          AddCardResult addCardResult = AddCardResult.fromJson(result);
          if (customer.cardUserKey == null) {
            CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('customer');
            await collectionReference
                .doc(customer.uid)
                .update({"cardUserKey": addCardResult.cardUserKey});
          }
          return addCardResult;
        } else {
          ErrorModel error = ErrorModel.fromJson(result);
          debugPrint(error.toString());
          return error;
        }
      }else{
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<Object?> delCard(String cardToken, String cardUserKey) async {
    var url = Uri.https(
        'us-central1-heryerpark-ms.cloudfunctions.net', 'delCard');
    var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cardToken': cardToken,
        'cardUserKey': cardUserKey,
      }),
    );
    var result = json.decode(response.body);
    if (result["status"] == "success") {
      return true;
    } else {
      ErrorModel error = ErrorModel.fromJson(result);
      debugPrint(error.toString());
      return error;
    }
  }

  @override
  Future<Object?> getCards() async {
    try {
      var customer = await getCurrentCustomer();

      if (customer is CustomerModel && customer.cardUserKey != null) {
        var url = Uri.https(
            'us-central1-heryerpark-ms.cloudfunctions.net', 'getCards');
        var response = await http.post(url,
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
            body: jsonEncode({
              'cardUserKey': customer.cardUserKey,
            }));
        var result = json.decode(response.body);
        if (result["status"] == "success") {
          GetCardsResultModel getCardsResultModel =
          GetCardsResultModel.fromJson(result);
          return getCardsResultModel;
        } else {
          ErrorModel error = ErrorModel.fromJson(result);
          return error;
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("AuthService - Exception - getCards : ${e.toString()}");
      return null;
    }

  }

  @override
  Future<Object?> pay(PayModel payModel) async {
    try {
      final ipv4 = await Ipify.ipv4();
      payModel.ip = ipv4;
      var url =
      Uri.https('us-central1-heryerpark-ms.cloudfunctions.net', 'pay');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(
          payModel.toJson(),
        ),
      );
      debugPrint(response.body);
      var result = json.decode(response.body);
      if (result["status"] == "success") {
        PayResult payResult = PayResult.fromJson(result);
        return payResult;
      } else {
        ErrorModel error = ErrorModel.fromJson(result);
        return error;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }

  }
}
