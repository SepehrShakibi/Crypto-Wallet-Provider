import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:crypto_wallet/constants/snackbar_constant.dart';
import 'package:crypto_wallet/exception/auth_exception.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/providers/auth_provider.dart';
import 'package:crypto_wallet/providers/transaction_provider.dart';
import 'package:crypto_wallet/widgets/register_page_widget/password/registerpage_password_listtile.dart';
import 'package:crypto_wallet/widgets/generic_widget/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/widgets/register_page_widget/input/registerpage_input_listtile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _firstnameController;
  late final TextEditingController _lastnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _repeatPasswordController;

  @override
  void initState() {
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  bool passwordConfirm() {
    if (_firstnameController.text.trim().isEmpty ||
        _lastnameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        _repeatPasswordController.text.trim().isEmpty) {
      showSnackbar(
        context: context,
        text: 'Please Complete fields',
      );

      return false;
    } else if (_passwordController.text.trim() !=
        _repeatPasswordController.text.trim()) {
      showSnackbar(
        context: context,
        text: 'Passwords are not the same',
      );

      return false;
    } else if ((_passwordController.text.trim() ==
            _repeatPasswordController.text.trim()) &
        _passwordController.text.trim().isNotEmpty &
        _repeatPasswordController.text.trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    final authProvider = context.read<AuthProvider>();
    context.read<TransactionProvider>().resetLocalTransacion;
    if (passwordConfirm()) {
      LoadingScreen().show(
        context: context,
        text: 'Please wait a moment....',
      );
      try {
        await authProvider.createFirebaseUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await authProvider.createFirestoreUser(
          firstname: _firstnameController.text.trim(),
          lastname: _lastnameController.text.trim(),
          email: _emailController.text.trim(),
        );
      } on WeakPasswordAuthException {
        showSnackbar(
            context: context,
            text: 'Your password is weak!\nPlease choose a strong password.');
      } on EmailAlreadyInUseException {
        showSnackbar(
          context: context,
          text: 'Email already signed up!Please Login',
        );
      } on InvalidEmailAuthException {
        showSnackbar(
          context: context,
          text: 'Please enter valid email adress.',
        );
      } on GenericAuthException {
        showSnackbar(
          context: context,
          text: 'Sorry...\nThere is a problem.\nPlease try again.',
        );
      } catch (_) {
        showSnackbar(
          context: context,
          text: 'Sorry...\nThere is a problem.\nPlease try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,

        //   backgroundColor: KbackgroundColor,
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
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
                    SizedBox(height: size.height / 35),
                    const Text(
                      "Register",
                      style: TextStyle(
                          fontFamily: 'BebasNeueR',
                          color: Colors.white,
                          fontSize: 45),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        InputListtileRegisterPage(
                          controller: _firstnameController,
                          icon: Icons.abc,
                          hinttext: 'Jack',
                          textInputType: TextInputType.name,
                          title: 'Firstname',
                        ),
                        InputListtileRegisterPage(
                          controller: _lastnameController,
                          icon: Icons.abc,
                          hinttext: 'Ramsay',
                          textInputType: TextInputType.name,
                          title: 'Lastname',
                        ),
                        InputListtileRegisterPage(
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          hinttext: 'CryptoWallet@email.com',
                          textInputType: TextInputType.emailAddress,
                          title: 'Email',
                        ),
                        RegisterPagePasswordListtile(
                          controller: _passwordController,
                          title: 'Password',
                          hinttext: 'Choose your password',
                          icon: Icons.password_outlined,
                        ),
                        RegisterPagePasswordListtile(
                            controller: _repeatPasswordController,
                            title: 'Repeat Password',
                            hinttext: 'Repeat Password',
                            icon: Icons.password_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        ApplyButton(
                          width: size.width,
                          size: size,
                          onTap: signUp,
                          color: Colors.white.withOpacity(0.4),
                          text: 'Register',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Member? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'CharisSILB'),
                            ),
                            GestureDetector(
                              onTap: authProvider.toggleAuthPage,
                              child: const Text("Login Now!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: KsuboptionColor,
                                      fontSize: 15,
                                      fontFamily: 'CharisSILB')),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
