import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/base/card_base.dart';
import 'package:customer/core/model/iyzico/add_card_model.dart';
import 'package:customer/core/model/iyzico/add_card_result_model.dart';
import 'package:customer/core/model/iyzico/error_model.dart';
import 'package:customer/core/model/iyzico/get_cards_result_model.dart';
import 'package:customer/core/model/iyzico/pay_model.dart';
import 'package:customer/core/model/iyzico/pay_result_model.dart';
import 'package:customer/core/service/auth_service.dart';
import 'package:customer/locator.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CardService implements CardBase {

  @override
  Future<Object?> getCards() async {
    try {
      String? cardUserKey = locator<AuthService>().cardUserKey;
      if (cardUserKey != null) {
        var url = Uri.https(
            'us-central1-heryerpark-ms.cloudfunctions.net', 'getCards');
        var response = await http.post(url,
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
            body: jsonEncode({
              'cardUserKey': cardUserKey,
            }));
        var result = json.decode(response.body);

        if (result["status"] == "success") {
          GetCardsResultModel getCardsResultModel =
              GetCardsResultModel.fromJson(result);
          debugPrint(getCardsResultModel.toString());
          return getCardsResultModel;
        } else {
          ErrorModel error = ErrorModel.fromJson(result);
          debugPrint(error.toString());
          return error;
        }
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<Object?> addCard(AddCardModel addCardModel) async {}

  @override
  Future<Object?> delCard(String cardToken, String cardUserKey) async {}

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
