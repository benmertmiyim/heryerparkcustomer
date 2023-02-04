import 'package:customer/core/model/coupon_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/coupon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coupons"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
          future: Provider.of<AuthView>(context, listen: false).getCoupons(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<CouponModel> coupons = snapshot.data as List<CouponModel>;
              if(coupons.isNotEmpty){
                return ListView.builder(
                  itemCount: coupons.length+1,
                  itemBuilder: (context, i){
                    if(i == 0) return const SizedBox(height: 16,);
                    return CouponWidget(couponModel: coupons[i-1],);
                  },
                );
              }else{
                return const Center(
                  child: Text("No Coupons"),
                );
              }
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }
        ),
      ),
    );
  }
}
