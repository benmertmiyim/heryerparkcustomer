
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/extensions/phone_extension.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String nameSurname = "";
  String phone = "";

  bool _passwordVisible = true;


  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          //key: Key("back"),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: "HerYer",
                            style: TextStyle(
                                fontSize: theme.textTheme.titleLarge!.fontSize,
                                color: theme.colorScheme.onPrimary,
                                fontStyle: FontStyle.italic),
                          ),
                          TextSpan(
                            text: "Park",
                            style: TextStyle(
                                fontSize: theme.textTheme.titleLarge!.fontSize,
                                color: theme.colorScheme.secondary,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      TextFormField(
                        key: Key("email_reg"),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context).login_screen_enter_email;
                          } else {
                            if (!value.contains("@") || !value.contains(".")) {
                              return AppLocalizations.of(context).login_screen_enter_email;
                            } else {
                              email = value;
                            }
                          }
                          return null;
                        },

                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).login_screen_example_mail,
                          label: Text(AppLocalizations.of(context).login_screen_email_adress),

                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: const Icon(
                            MdiIcons.emailOutline,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        key: Key("name_reg"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context).login_screen_please_enter_name_surname;
                          }
                          nameSurname = value;
                          return null;
                        },

                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).login_screen_example_name,
                          label: Text(AppLocalizations.of(context).login_screen_name_surname),

                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: const Icon(
                            MdiIcons.accountOutline,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          key: Key("password_reg"),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context).login_screen_password_warning;
                          } else {
                            password = value;
                          }
                          return null;
                        },
                        autofocus: false,
                        obscureText: _passwordVisible,
                        textInputAction: TextInputAction.next,

                        decoration: InputDecoration(

                          label: Text(AppLocalizations.of(context).login_screen_password),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: const Icon(
                            MdiIcons.lockOutline,
                            size: 22,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible
                                  ? MdiIcons.eyeOutline
                                  : MdiIcons.eyeOffOutline,
                              size: 22,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        key: Key("password2_reg"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context).login_screen_same_password;
                          } else {
                            if (password != value) {
                              return AppLocalizations.of(context).login_screen_please_enter_same_password;
                            }
                          }
                          return null;
                        },
                        autofocus: false,
                        obscureText: _passwordVisible,
                        textInputAction: TextInputAction.next,

                        decoration: InputDecoration(
                          label: Text(AppLocalizations.of(context).login_screen_password_again),

                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: const Icon(
                            MdiIcons.lockOutline,
                            size: 22,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: Icon(
                              _passwordVisible
                                  ? MdiIcons.eyeOutline
                                  : MdiIcons.eyeOffOutline,
                              size: 22,
                            ),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        key: Key("phone_reg"),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 17) {
                            return AppLocalizations.of(context).login_screen_enter_phone;
                          } else {
                            phone = value;
                          }
                          return null;
                        },
                        controller:
                        MaskedTextController(mask: '+90 --- --- -- --'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "+90",
                          label: Text(AppLocalizations.of(context).login_screen_phone),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          prefixIcon: Icon(
                            MdiIcons.accountOutline,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(0),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Consumer<AuthView>(
                        builder: (BuildContext context, value, Widget? child) {
                          if (value.authProcess == AuthProcess.idle) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                key: Key("register"),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    phone = phone.replaceAll(" ", "");
                                    await value
                                        .createUserWithEmailAndPassword(
                                            email, password, phone, nameSurname)
                                        .then((res) {
                                      if (res is String) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(res,),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context).login_screen_register,
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
