import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/constants/snackbar_constant.dart';
import 'package:crypto_wallet/exception/neworking_exception.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/providers/auth_provider.dart';
import 'package:crypto_wallet/providers/charts_provider.dart';
import 'package:crypto_wallet/providers/price_balance_provider.dart';
import 'package:crypto_wallet/providers/transaction_provider.dart';
import 'package:crypto_wallet/widgets/login_page_widget/input_text_field.dart';
import 'package:crypto_wallet/widgets/login_page_widget/password_text_field.dart';
import 'package:crypto_wallet/widgets/generic_widget/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/exception/auth_exception.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void login(BuildContext context) async {
    final priceBalanceProvider = context.read<PriceBalanceProvider>();
    final chartProvider = context.read<ChartsProvider>();
    final transactionProvider = context.read<TransactionProvider>();
    final authProvider = context.read<AuthProvider>();
    try {
      if (_emailController.text.trim().isNotEmpty &
          _passwordController.text.trim().isNotEmpty) {
        LoadingScreen().show(context: context, text: 'Please wait a moment...');

        await authProvider.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await priceBalanceProvider.initialBlance();
        await transactionProvider.initialTransaction();
        await priceBalanceProvider.setPriceOnline();
        await chartProvider.setCharts();
      } else {
        LoadingScreen().hide();
        var snackBar = const SnackBar(
            backgroundColor: Color.fromARGB(255, 28, 28, 28),
            content: Text(
              'Please Complete Data',
              style: TextStyle(fontFamily: 'RobotoR'),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on UserNotFoundAuthException {
      LoadingScreen().hide();
      showSnackbar(
        context: context,
        text: 'User not found...\nPlease try again.',
      );
    } on WrongPasswordAuthException {
      LoadingScreen().hide();
      showSnackbar(
        context: context,
        text: 'Wrong user credential...\nPlease try again.',
      );
    } on GenericAuthException {
      LoadingScreen().hide();
      showSnackbar(
        context: context,
        text: 'Sorry...\nThere is a problem.\nPlease try again.',
      );
    } on GenericNetworkingException {
      showSnackbar(
        context: context,
        text:
            'Sorry...\nThere is a problem in getting data.\nPlease try again.',
      );
    } catch (e) {
      LoadingScreen().hide();
      showSnackbar(
        context: context,
        text: 'Sorry...\nThere is a problem.\nPlease try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authProvider = context.read<AuthProvider>();
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/register_background.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.height / 2.1,
                      width: size.height / 30,
                      child: Lottie.asset("assets/animations/xW5sHdHxwE.json"),
                    ),
                    SizedBox(
                      height: size.height / 200,
                    ),
                    const Text(
                      "Welcome to \nCrypto Wallet App",
                      style: TextStyle(
                          fontFamily: 'BebasNeueR',
                          color: Colors.white,
                          fontSize: 45),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputTextField(
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      hintText: "CryptoWallet@email.Com",
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordTextField(
                      controller: _passwordController,
                      prefixIcon: Icons.password_outlined,
                      hintText: 'Your Strong Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, forgetPasswordPage),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KsuboptionColor,
                              fontSize: 13,
                              fontFamily: 'CharisSILB'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ApplyButton(
                      width: size.width,
                      text: 'Login',
                      size: size,
                      onTap: () => login(context),
                      color: KButtonBackgroundColor1.withOpacity(0.9),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not Member? ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13,
                              fontFamily: 'CharisSILB'),
                        ),
                        GestureDetector(
                          onTap: authProvider.toggleAuthPage,
                          child: const Text("Register Now!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: KsuboptionColor,
                                  fontSize: 14,
                                  fontFamily: 'CharisSILB')),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
