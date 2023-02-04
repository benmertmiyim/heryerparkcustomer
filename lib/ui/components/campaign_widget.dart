import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/campaing_model.dart';
import 'package:customer/ui/screen/main/campaign_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CampaignWidget extends StatefulWidget {
  final CampaignModel campaignModel;

  const CampaignWidget({Key? key, required this.campaignModel})
      : super(key: key);

  @override
  State<CampaignWidget> createState() => _CampaignWidgetState();
}

class _CampaignWidgetState extends State<CampaignWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (c)=>CampaignDetailScreen(campaignModel: widget.campaignModel,),),);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.campaignModel.id,
                child: CachedNetworkImage(
                  imageUrl: widget.campaignModel.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.campaignModel.title),
                        Text(
                          "Validation Date: ${DateFormat('dd MMMM yyyy').format(widget.campaignModel.validationDate)}",
                          ),
                      ],
                    ),
                    Container(
                      child: Icon(MdiIcons.chevronRight,
                          size: 22,),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
