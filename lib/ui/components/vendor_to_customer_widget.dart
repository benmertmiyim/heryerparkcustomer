import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VendorToCustomerWidget extends StatelessWidget {
  final String email;

  const VendorToCustomerWidget({Key? key, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    ThemeData theme = Theme.of(context);

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                AppLocalizations.of(context).vendor_to_customer_convert,
              ),
            ),
            const Divider(),
            Text(
              AppLocalizations.of(context).vendor_to_customer_youhavealready,
            ),
            authView.authProcess == AuthProcess.idle
                ? Container(
                    margin: EdgeInsets.only(top: 24),
                    alignment: AlignmentDirectional.centerEnd,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context).vendor_to_customer_decline,
                            ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await authView
                                .vendorToCustomer(email)
                                .then((value) {
                              String message =
                                  AppLocalizations.of(context).vendor_to_customer_converting_to_customer_is_successful;
                              if (value is String) {
                                message = value;
                              }
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    message,
                                    ),
                                  backgroundColor: theme.colorScheme.primary,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            });
                          },
                          child: Text(
                            AppLocalizations.of(context).request_screen_accept,
                            ),
                        ),
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
      ),
    );
  }
}
