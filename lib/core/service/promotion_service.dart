import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer/core/base/notification_base.dart';
import 'package:customer/core/base/promotion_base.dart';
import 'package:customer/core/model/banner_model.dart';
import 'package:customer/core/model/campaing_model.dart';
import 'package:customer/core/model/notification_model.dart';

class PromotionService implements PromotionBase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("banner").where("active",isEqualTo: true).get();
      List<BannerModel> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String,dynamic> bannerMap = querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(BannerModel.fromJson(bannerMap,),);
      }
      return list;
    } catch (e) {
      debugPrint(
        "PromotionView - Exception - Get Banners : ${e.toString()}",
      );
      return [];
    }

  }

  @override
  Future<List<CampaignModel>> getCampaigns() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection("campaign").get();
      List<CampaignModel> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String,dynamic> campaignMap = querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(CampaignModel.fromJson(campaignMap,),);
      }
      return list;
    } catch (e) {
      debugPrint(
        "PromotionView - Exception - Get Campaigns : ${e.toString()}",
      );
      return [];
    }
  }

}
