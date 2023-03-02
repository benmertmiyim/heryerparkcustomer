import 'package:customer/core/model/iyzico/get_cards_result_model.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:customer/ui/components/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final bool isFromPayment;

  const PaymentMethodsScreen({Key? key, required this.isFromPayment})
      : super(key: key);

  cardWidget(BuildContext context, GetCardsResultModel getCardsResultModel,
      int i, CardView cardView) {
    if (isFromPayment) {
      return InkWell(
        onTap: () {
          cardView.selectedCard = getCardsResultModel.cardDetails![i];
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
    CardView cardView = Provider.of<CardView>(context,);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Methods"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(
          //  context,
          //  MaterialPageRoute(
          //    builder: (context) => const AddCreditCardScreen(),
          //  ),
          //);
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: cardView.getCards(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is GetCardsResultModel) {
              GetCardsResultModel cardResultModel =
                  snapshot.data as GetCardsResultModel;

              if (cardResultModel.cardDetails!.isNotEmpty) {
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: cardResultModel.cardDetails!.length,
                        itemBuilder: (BuildContext context, int i) {
                          return cardWidget(
                              context, cardResultModel, i, cardView);
                        }),
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
                );
              }
            }

            return const Center(
              child: Text("Kart yok"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
