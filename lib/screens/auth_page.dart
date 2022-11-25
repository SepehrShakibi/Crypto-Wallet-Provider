import 'package:crypto_wallet/providers/auth_provider.dart';
import 'package:crypto_wallet/screens/login_page.dart';
import 'package:crypto_wallet/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return authProvider.showLoginPage
        ? const LoginPage()
        : const RegisterPage();
  }
}
