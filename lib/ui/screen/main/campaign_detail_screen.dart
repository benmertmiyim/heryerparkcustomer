import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer/core/model/campaing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class CampaignDetailScreen extends StatefulWidget {
  final CampaignModel campaignModel;

  const CampaignDetailScreen({Key? key, required this.campaignModel})
      : super(key: key);

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.campaignModel.title),
      ),
      body: ListView(
        children: [
          Hero(
            tag: widget.campaignModel.id,
            child: CachedNetworkImage(
              imageUrl: widget.campaignModel.imageURL,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: HtmlWidget(widget.campaignModel.description),
          ),
        ],
      ),
    );
  }
}
