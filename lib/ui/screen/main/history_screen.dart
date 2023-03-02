import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/components/history_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late AuthView authView;

  Future onRefresh() async {
    await authView.getParkHistory(authView.customer!.uid);
  }

  @override
  Widget build(BuildContext context) {
    authView = Provider.of<AuthView>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Park History"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: authView.parkHistory.isNotEmpty
              ? authView.parkHistory
                  .map((model) => HistoryWidget(parkHistory: model,isMainScreen: false,))
                  .toList()
              : [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text(
                        "You don't have park history",
                      ),
                    ),
                  )
                ],
        ),
      ),
    );
  }
}
