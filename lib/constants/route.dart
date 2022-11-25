import 'package:crypto_wallet/screens/login_page.dart';
import 'package:crypto_wallet/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:crypto_wallet/screens/forget_page.dart';
import 'package:crypto_wallet/screens/home_page.dart';
import 'package:crypto_wallet/screens/transaction_page.dart';
import 'package:crypto_wallet/screens/user_page.dart';
import 'package:page_transition/page_transition.dart';

const userPage = 'user_page';
const loginPage = 'login_page';
const registerPage = 'register_page';
const forgetPasswordPage = 'forget_password_page';
const homePage = 'home_page';
const transactionListPage = 'transaction_list_page';

Map<String, Widget Function(BuildContext)> allRoute() => {
      userPage: ((context) => const UserPage()),
      loginPage: ((context) => const LoginPage()),
      registerPage: ((context) => const RegisterPage()),
      forgetPasswordPage: ((context) => const ForgetPasswordPage()),
      homePage: ((context) => const HomePage()),
      transactionListPage: (context) => const TransactionPage()
    };

Route<dynamic>? Function(RouteSettings) allGenerateRoute() => (settings) {
      switch (settings.name) {
        case userPage:
          return PageTransition(
              child: const UserPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350));

        case forgetPasswordPage:
          return PageTransition(
              child: const ForgetPasswordPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350));
        case homePage:
          return PageTransition(
              child: const HomePage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350));
        case transactionListPage:
          return PageTransition(
              child: const TransactionPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350));
        default:
          return PageTransition(
              child: const UserPage(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350));
      }
    };
