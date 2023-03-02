import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/screen/main/payment_screen.dart';
import 'package:customer/ui/screen/auth/login_screen.dart';
import 'package:customer/ui/screen/auth/phone_verification_screen.dart';
import 'package:customer/ui/screen/main/main_screen.dart';
import 'package:customer/ui/screen/main/request_screen.dart';
import 'package:customer/ui/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    if (authView.authState == AuthState.landing) {
      return const SplashScreen();
    } else {
      if (authView.authState == AuthState.intro) {
        //return const IntroductionAnimationScreen();
        return const LoginScreen();
      } else if (authView.authState == AuthState.unauthorized) {
        return const LoginScreen();
      } else if (authView.authState == AuthState.phone) {
        return const PhoneVerificationScreen();
      } else {
        if (authView.paymentParks.isNotEmpty) {
          return PaymentScreen(
            parkHistory: authView.paymentParks.first,
          );
        } else if (authView.approvalParks.isNotEmpty) {
          return RequestScreen(
            parkHistory: authView.approvalParks.first,
          );
        } else {
          return const MainScreen();
        }
      }
    }
  }
}
