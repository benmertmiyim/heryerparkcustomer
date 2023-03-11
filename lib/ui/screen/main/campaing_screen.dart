import 'package:customer/core/view/promotion_view.dart';
import 'package:customer/ui/components/campaign_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CampaignScreen extends StatelessWidget {
  const CampaignScreen({Key? key}) : super(key: key);


  content(PromotionView promotionView) {
    if (promotionView.promotionProcess == PromotionProcess.idle) {
      final campaignList = promotionView.campaignList;
      if (campaignList.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
              itemCount: campaignList.length,
              itemBuilder: (c, i) {
                return CampaignWidget(campaignModel: campaignList[i]);
              }),
        );
      } else {
        return  const Center(
          child: Text("No Campaign"),
        );
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    PromotionView promotionView = Provider.of<PromotionView>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Campaigns"),
      ),
      body: content(promotionView),
    );
  }
}
