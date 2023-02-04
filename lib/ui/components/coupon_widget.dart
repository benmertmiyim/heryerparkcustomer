import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:customer/core/model/coupon_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CouponWidget extends StatelessWidget {
  final CouponModel couponModel;
  const CouponWidget({Key? key, required this.couponModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return CouponCard(
      height: 128,
      curveAxis: Axis.vertical,
      firstChild: Container(
        color: theme.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Text(
                      "${couponModel.price.toStringAsFixed(0)}₺",
                      style:  TextStyle(
                        fontSize: 24,
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider( height: 0),
             Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    couponModel.title,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        color: theme.colorScheme.secondary,
        width: double.maxFinite,
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coupon Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSecondary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                ),
            ),
            SizedBox(height: 4),
            Text(
              couponModel.code,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: theme.colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              "Valid until: ${                        DateFormat('dd MMM yy')
                  .format(couponModel.validDate)}",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: theme.colorScheme.onSecondary,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
