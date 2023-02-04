import 'package:flutter/material.dart';
import 'package:customer/core/base/notification_base.dart';
import 'package:customer/core/base/promotion_base.dart';
import 'package:customer/core/model/banner_model.dart';
import 'package:customer/core/model/campaing_model.dart';
import 'package:customer/core/model/notification_model.dart';
import 'package:customer/core/service/notification_service.dart';
import 'package:customer/core/service/promotion_service.dart';
import 'package:customer/locator.dart';

enum PromotionProcess {
  idle,
  busy,
}

class PromotionView with ChangeNotifier implements PromotionBase {
  PromotionService promotionService = locator<PromotionService>();
  PromotionProcess _promotionProcess = PromotionProcess.idle;
  List<BannerModel> bannerList = [];
  List<CampaignModel> campaignList = [];

  PromotionProcess get promotionProcess => _promotionProcess;

  set promotionProcess(PromotionProcess value) {
    _promotionProcess = value;
    notifyListeners();
  }

  PromotionView() {
    getBanners();
    getCampaigns();
  }


  @override
  Future<List<BannerModel>> getBanners() async {
    try{
      promotionProcess = PromotionProcess.busy;
      bannerList = await promotionService.getBanners();
      return bannerList;
    } catch (e) {
      debugPrint(
        "PromotionView - Exception - Get Banners : ${e.toString()}",
      );
      return [];
    }finally {
      promotionProcess = PromotionProcess.idle;
    }
  }

  @override
  Future<List<CampaignModel>> getCampaigns() async {
    try{
      promotionProcess = PromotionProcess.busy;
      campaignList = await promotionService.getCampaigns();
      return campaignList;
    } catch (e) {
      debugPrint(
        "PromotionView - Exception - Get Campaigns : ${e.toString()}",
      );
      return [];
    } finally {
      promotionProcess = PromotionProcess.idle;
    }
  }
}
