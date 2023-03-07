import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/auth_base.dart';
import 'package:customer/core/model/coupon_model.dart';
import 'package:customer/core/model/customer_model.dart';
import 'package:customer/core/model/enum.dart';
import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/add_card_result_model.dart';
import 'package:customer/core/model/iyzico/card_result_model.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/model/iyzico/get_cards_result_model.dart';
import 'package:customer/core/model/iyzico/pay_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/model/park_history_model.dart';
import 'package:customer/core/model/rate_model.dart';
import 'package:customer/core/model/vendor_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/locator.dart';
import 'package:customer/ui/components/marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

enum AuthProcess {
  idle,
  busy,
}

enum AuthState {
  authorized,
  landing,
  intro,
  unauthorized,
  phone,
}

class AuthView with ChangeNotifier implements AuthBase {
  AuthProcess _authProcess = AuthProcess.idle;
  AuthState _authState = AuthState.landing;
  AuthService authService = locator<AuthService>();
  CustomerModel? _customer;
  StreamSubscription? listenerForApprovalOrPayment;
  String? messageCode; //TODO: burayı sil
  CardResultModel? _selectedCard;
  GetCardsResultModel? cards;
  List<VendorModel> nearVendors = [];
  Set<Marker> markers = {};

  set selectedCard(CardResultModel? value) {
    _selectedCard = value;
    notifyListeners();
  }

  CardResultModel? get selectedCard => _selectedCard;

  List<ParkHistory> approvalParks = [];
  List<ParkHistory> paymentParks = [];
  List<ParkHistory> processParks = [];
  List<ParkHistory> parkHistory = [];

  CustomerModel? get customer => _customer;

  AuthProcess get authProcess => _authProcess;

  set authProcess(AuthProcess value) {
    _authProcess = value;
    notifyListeners();
  }

  AuthState get authState => _authState;

  set authState(AuthState value) {
    _authState = value;
    notifyListeners();
  }

  AuthView() {
    getCurrentCustomer();
  }

  @override
  Future<Object?> getCurrentCustomer() async {
    try {
      authProcess = AuthProcess.busy;
      var res = await authService.getCurrentCustomer();
      if(res is CustomerModel) {
        _customer = res;
        await generateCode();
        await getCards();
        await getParkHistory(customer!.uid);
        getApprovalOrPaymentOrProcess(customer!.uid);
        if(!customer!.verified!) {
          await sendCode(customer!.phone);
          authState = AuthState.phone;
        } else {
          authState = AuthState.authorized;
        }
        debugPrint(
          "AuthView - Current Customer : $customer",
        );
        return customer;
      } else{
        authState = AuthState.unauthorized;
        return res;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - Get Current Customer : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      authProcess = AuthProcess.busy;
      var res = await authService.signInWithEmailAndPassword(email, password);
      if (res is CustomerModel) {
        _customer = res;
        await generateCode();
        await getCards();
        await getParkHistory(customer!.uid);
        getApprovalOrPaymentOrProcess(customer!.uid);
        if(!customer!.verified!) {
          await sendCode(customer!.phone);
          authState = AuthState.phone;
        } else {
          authState = AuthState.authorized;
        }
        debugPrint(
          "AuthView - Sign In With Email And Password : $customer",
        );
        return customer;
      } else {
        authState = AuthState.unauthorized;
        return res;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signInWithEmailAndPassword : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future signOut() async {
    try {
      await authService.signOut();
      _customer = null;
      authState = AuthState.unauthorized;
      clearListenerForApprovalOrPayment();
      listenerForApprovalOrPayment!.cancel();
      messageCode = "";
      cards = null;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signOut : ${e.toString()}",
      );
    }
  }

  @override
  Future<Object?> createUserWithEmailAndPassword(
      String email, String password, String phone, String nameSurname) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.createUserWithEmailAndPassword(
          email, password, phone, nameSurname);
      if (result is CustomerModel) {
        _customer = result;
        getApprovalOrPaymentOrProcess(customer!.uid);
        await getParkHistory(customer!.uid);
        generateCode();
        await getCards();
        if(!customer!.verified!) {
          await sendCode(customer!.phone);
          authState = AuthState.phone;
        } else {
          authState = AuthState.authorized;
        }

        debugPrint(
          "AuthView - createUserWithEmailAndPassword : $customer",
        );
        return customer;
      } else {
        authState = AuthState.unauthorized;
        return result;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - createUserWithEmailAndPassword : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      authProcess = AuthProcess.busy;
      return await authService.sendPasswordResetEmail(email);
    } catch (e) {
      debugPrint(
        "AuthView - Exception - sendPasswordResetEmail : ${e.toString()}",
      );
      return null;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<String> changeCustomerImage(File customerImage) async {
    try {
      authProcess = AuthProcess.busy;
      String res = await authService.changeCustomerImage(customerImage);
      if(res != "Something went wrong") {
        _customer!.customerImage = res;
      }
      return res;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - changeCustomerImage : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<List<CouponModel>> getCoupons() async {
    try {
      return await authService.getCoupons();
    } catch (e) {
      debugPrint(
        "AuthView - Exception - getCoupons : ${e.toString()}",
      );
      return [];
    }
  }

  @override
  Future<Object?> sendCode(String phone)async{
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.sendCode(phone);
      Map data = jsonDecode(result.toString());
      messageCode = data["code"];
      debugPrint(data.toString());
      return result;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - sendCode : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<bool> verifyCode(String code)async{
    try {
      authProcess = AuthProcess.busy;
      var res= await authService.verifyCode(code);
      if(res){
        authState = AuthState.authorized;
        customer!.verified = true;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - sendCode : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> vendorToCustomer(String email) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.vendorToCustomer(email);

      if (result is CustomerModel) {
        _customer = result;
        if(!customer!.verified!) {
          await sendCode(customer!.phone);
          authState = AuthState.phone;
        } else {
          authState = AuthState.authorized;
        }
        debugPrint(
          "AuthView - vendorToCustomer : $customer",
        );
        return customer;
      } else {
        authState = AuthState.unauthorized;
        return result;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - vendorToCustomer : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> generateCode() async {
    try {
      var result = await authService.generateCode();
      if (result is Map<String, dynamic>) {
        if(result["status"] == "success") {
          customer!.code = result["code"];
          customer!.codeTime = DateTime.tryParse(result["codeTime"]);
        }
        return result["message"];
      }else {
        return "Something went wrong";
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - generateCode : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>>? getApprovalOrPaymentOrProcess(String customerId) {
    var snapshot = authService.getApprovalOrPaymentOrProcess(customerId);
    listenerForApprovalOrPayment = snapshot!.listen((event) {
      clearListenerForApprovalOrPayment();
      for (var doc in event.docs) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        ParkHistory park = ParkHistory.fromJson(map);
        if (park.status == StatusEnum.approval) {
          approvalParks.add(park);
        } else if (park.status == StatusEnum.payment) {
          paymentParks.add(park);
        } else{
          processParks.add(park);
        }
      }
      notifyListeners();
    });
    return snapshot;

  }

  void clearListenerForApprovalOrPayment() {
    paymentParks = [];
    approvalParks = [];
    processParks = [];
  }

  @override
  Future<Object?> replyRequest(String vendorId, String customerId, String requestId, bool reply) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.replyRequest(vendorId, customerId, requestId, reply);
      return result;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - replyRequest : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }

  }

  @override
  Future<Object?> getParkHistory(String customerId) async {
    try {
      authProcess = AuthProcess.busy;
      var res = await authService.getParkHistory(customerId);
      if(res is List<ParkHistory>) {
        parkHistory = res;
      }
      return res;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - getParkHistory : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  Future<Object> applyCoupon(String couponCode) async {
    try {
      authProcess = AuthProcess.busy;
      var res = await getCoupons();
      debugPrint(res.toString());
      if(res.isNotEmpty) {
        for (var coupon in res) {
          if(coupon.code == couponCode) {
            return coupon;
          }
        }
      }

      return "Coupon not found";
    } catch (e) {
      debugPrint(
        "AuthView - Exception - applyCoupon : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> getVendor(String vendorId) async {
    try {
      authProcess = AuthProcess.busy;
      var res = await authService.getVendor(vendorId);

      return res;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - getVendor : ${e.toString()}",
      );
      return "Something went wrong";
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<bool> ratePark(RateModel rateModel) async {
    try {
      authProcess = AuthProcess.busy;
      for (var element in parkHistory) {
        if(element.requestId == rateModel.processId) {
          element.rated = true;
        }
      }
      await authService.ratePark(rateModel);
      return true;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - ratePark : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }

  }

  @override
  Future<List> getNearVendor(double latitude, double longitude, double radius, int? limit) async {
    try {
      authProcess = AuthProcess.busy;
      nearVendors = await authService.getNearVendor(latitude, longitude, radius, limit) as List<VendorModel>;
      markers = {};
      for (var element in nearVendors) {
        LatLng latLng = LatLng(element.latitude, element.longitude);
        markers.add(
          Marker(
              markerId: MarkerId(element.vendorId),
              position: latLng,
              icon: await MarkerWidget(vendorModel: element).toBitmapDescriptor()),
        );
      }
      return nearVendors;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - getNearVendor : ${e.toString()}",
      );
      return [];
    }finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<List> getVendorComments(String vendorId, bool detail) async {
    try {
      var res = await authService.getVendorComments(vendorId, detail);
      return res;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - getVendorComments : ${e.toString()}",
      );
      return [];
    }
  }

  @override
  Future<Object?> addCard(AddCardModel addCardModel) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.addCard(addCardModel);
      if(result is AddCardResult){
        customer!.cardUserKey = result.cardUserKey;
        getCards();
        return result;
      }else if (result is ErrorModel){
        return result;
      }else{
        return null;
      }
    } catch (e) {
      debugPrint(
        "CardView - Exception - addCard : ${e.toString()}",
      );
      return null;
    }finally{
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> delCard(String cardToken, String cardUserKey) async {
    try {
      if(cardToken == _selectedCard?.cardToken){
        selectedCard = null;
      }
      var result = await authService.delCard(cardToken,cardUserKey);
      if(result is bool){
        cards!.cardDetails!.removeWhere((element) => element.cardToken == cardToken);
        notifyListeners();
        return result;
      }else{
        return result as ErrorModel;
      }
    } catch (e) {
      debugPrint(
        "CardView - Exception - delCard : ${e.toString()}",
      );
      return null;
    }

  }

  @override
  Future<Object?> getCards() async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.getCards();
      if(result is GetCardsResultModel){
        cards = result;
        return result;
      }else if (result is ErrorModel){
        return result;
      }
      return null;
    } catch (e) {
      debugPrint(
        "CardView - Exception - getCards : ${e.toString()}",
      );
      return null;
    }finally{
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<Object?> pay(PayModel payModel) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.pay(payModel);
      if(result is PayResult){
        return result;
      }else{
        return result as ErrorModel;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - pay : ${e.toString()}",
      );
      return null;
    }finally{
      authProcess = AuthProcess.idle;
    }
  }
}
