import 'package:customer/core/model/rate_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/comments_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AllCommentsScreen extends StatelessWidget {
  final String vendorId;
  const AllCommentsScreen({Key? key, required this.vendorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    AuthView authView = Provider.of<AuthView>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text.rich(
            TextSpan(children: [
              TextSpan(
                text: "HerYer",
                style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontStyle: FontStyle.italic),
              ),
              TextSpan(
                text: "Park",
                style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          centerTitle: true,
        ),
      body:                     FutureBuilder(
          future:
          authView.getVendorComments(vendorId, true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data is List<RateModel>) {
                List<RateModel> rateList =
                snapshot.data as List<RateModel>;
                if (rateList.isNotEmpty) {
                  return ListView.separated(
                      separatorBuilder:
                          (BuildContext context, int index) =>
                      const Divider(),
                      shrinkWrap: true,
                      physics:
                      const BouncingScrollPhysics(),
                      primary: true,
                      itemCount: rateList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return CommentsWidget(
                            rateModel: rateList[i]);
                      });
                } else {
                  return  Center(
                    child: Center(child: Text(AppLocalizations.of(context).all_commend_screen_nocom)),
                  );
                }
              } else {
                return Center(
                  child: Center(child: Text(AppLocalizations.of(context).all_commend_screen_nocom)),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
