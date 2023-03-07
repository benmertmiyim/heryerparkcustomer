import 'package:customer/core/model/rate_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentsWidget extends StatelessWidget {
  final RateModel rateModel;

  const CommentsWidget({Key? key, required this.rateModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd MMM yy kk:mm').format(rateModel.rateDate!),
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.textTheme.titleSmall!.color!.withOpacity(0.5),
            ),
          ),
          Row(
            children: [
              Text(
                "Security: ",
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              Text(
                rateModel.security.toStringAsFixed(1),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.star,
                size: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Service Quality: ",
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              Text(
                rateModel.serviceQuality.toStringAsFixed(1),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.star,
                size: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Accessibility: ",
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
              Text(
                rateModel.accessibility.toStringAsFixed(1),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.star,
                size: Theme.of(context).textTheme.titleLarge!.fontSize,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
            ],
          ),
          Text(
            "Comment: ${rateModel.message == "" ? "-" : rateModel.message}",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
