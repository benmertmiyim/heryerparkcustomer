import 'package:customer/core/model/iyzico/get_cards_result_model.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/card_widget.dart';
import 'package:customer/ui/screen/main/add_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class PaymentMethodsScreen extends StatelessWidget {
  final bool isFromPayment;

  const PaymentMethodsScreen({Key? key, required this.isFromPayment})
      : super(key: key);

  cardWidget(BuildContext context, GetCardsResultModel getCardsResultModel,
      int i, AuthView authView) {
    if (isFromPayment) {
      return InkWell(
        onTap: () {
          authView.selectedCard = getCardsResultModel.cardDetails![i];
          Navigator.pop(context);
        },
        child: CardWidget(cardResultModel: getCardsResultModel.cardDetails![i]),
      );
    } else {
      return CardWidget(cardResultModel: getCardsResultModel.cardDetails![i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    AuthView authView = Provider.of<AuthView>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).profile_screen_payment),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCreditCard(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          authView.authProcess == AuthProcess.idle
              ? (authView.cards != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: authView.cards!.cardDetails!.length,
                      itemBuilder: (BuildContext context, int i) {
                        return cardWidget(
                            context, authView.cards!, i, authView);
                      })
                  : Center(
                      child: Text(AppLocalizations.of(context).payment_screen_no),
                    ))
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          const SizedBox(
            height: 16,
          ),
          Image.asset(
            brightness == Brightness.dark
                ? "assets/images/iyzico_white.png"
                : "assets/images/iyzico_colored.png",
            width: MediaQuery.of(context).size.width / 3,
          ),
        ],
      ),
    );
  }
}
