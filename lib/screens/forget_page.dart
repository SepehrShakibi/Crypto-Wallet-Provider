import 'package:crypto_wallet/constants/snackbar_constant.dart';
import 'package:crypto_wallet/exception/auth_exception.dart';
import 'package:crypto_wallet/providers/auth_provider.dart';
import 'package:crypto_wallet/widgets/login_page_widget/input_text_field.dart';
import 'package:crypto_wallet/widgets/generic_widget/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final TextEditingController _emailController;

  Future<void> sendForgetPasswordEmail() async {
    final authProvider = context.read<AuthProvider>();

    try {
      if (_emailController.text.trim().isNotEmpty) {
        await authProvider.sendPasswordResetEmail(
            email: _emailController.text.trim());
      } else {
        showSnackbar(
          context: context,
          text: 'Please Enter Email',
        );
      }
    } on GenericAuthException {
      showSnackbar(
        context: context,
        text: 'Sorry...There is a problem!\nPlease try again.',
      );
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/forget_background.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Enter your Email",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'CharisSILB',
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.8,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputTextField(
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'CryptoWallet@email.com',
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ApplyButton(
                      width: size.width,
                      size: size,
                      onTap: sendForgetPasswordEmail,
                      color: Colors.white.withOpacity(0.4),
                      text: 'Send Email',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
