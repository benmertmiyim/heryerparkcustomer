import 'package:customer/core/model/banner_model.dart';
import 'package:customer/core/model/campaing_model.dart';

abstract class PromotionBase {
  Future<List<BannerModel>> getBanners();
  Future<List<CampaignModel>> getCampaigns();
}
