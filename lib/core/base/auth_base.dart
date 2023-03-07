import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/coupon_model.dart';
import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/pay_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/rate_model.dart';


abstract class AuthBase {
  Future<Object?> getCurrentCustomer();
  Future<Object?> signInWithEmailAndPassword(String email,String password);
  Future<Object?> sendPasswordResetEmail(String email);
  Future<Object?> createUserWithEmailAndPassword(String email,String password,String phone,String nameSurname);
  Future signOut();
  Future<String> changeCustomerImage(File customerImage);
  Future<List<CouponModel>> getCoupons();
  Future<Object?> sendCode(String phone);
  Future<bool> verifyCode(String code);
  Future<Object?> vendorToCustomer(String email,);
  Future<Object?> generateCode();
  Stream<QuerySnapshot>? getApprovalOrPaymentOrProcess(String customerId);
  Future<Object?> getParkHistory(String customerId);
  Future<Object?> replyRequest(String vendorId, String customerId, String requestId, bool reply);
  Future<Object?> getVendor(String vendorId);
  Future<List> getNearVendor(double latitude, double longitude, double radius, int? limit);
  Future<bool> ratePark(RateModel rateModel);
  Future<List> getVendorComments(String vendorId, bool detail);
  Future<Object?> getCards();
  Future<Object?> pay(PayModel payModel);
  Future<Object?> addCard(AddCardModel addCardModel);
  Future<Object?> delCard(String cardToken, String cardUserKey);
}
