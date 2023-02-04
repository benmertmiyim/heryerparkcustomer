import 'package:customer/l10n/l10n.dart';
import 'package:customer/provider/local_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectLanguageDialog extends StatefulWidget {
  const SelectLanguageDialog({Key? key}) : super(key: key);

  @override
  _SelectLanguageDialogState createState() => _SelectLanguageDialogState();
}

class _SelectLanguageDialogState extends State<SelectLanguageDialog> {

  Locale? currentLanguage;

  @override
  initState() {
    super.initState();
  }

  Future<void> handleRadioValueChange(Locale locale) async {
    setState(() {
      Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (BuildContext context, LocaleProvider value, Widget? child) {
        currentLanguage = value.locale;
        return Dialog(
          child: Container(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
                mainAxisSize: MainAxisSize.min, children: _buildOptions()),
          ),
        );
      },
    );
  }

  _buildOptions() {
    List<Widget> list = [];

    for (Locale language in L10n.all) {
      list.add(InkWell(
        onTap: () {
          handleRadioValueChange(language);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              Radio<Locale>(
                onChanged: (dynamic value) {
                  handleRadioValueChange(language);
                },
                groupValue: currentLanguage,
                value: language,
              ),
              Text(
                language.toString(),
              ),
            ],
          ),
        ),
      ));
    }

    return list;
  }
}
