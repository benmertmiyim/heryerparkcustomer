import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/model/coupon_model.dart';


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
  Future<Object?> replyRequest(String vendorId, String customerId, String requestId, bool reply);
}
