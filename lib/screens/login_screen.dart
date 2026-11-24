import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/feedback.dart';
import '../widgets/app_text_field.dart';
import '../widgets/fill_scroll_view.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Sem backend: qualquer login leva direto para a Home.
  void _login() {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FillScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            children: [
              const _Logo(),
              const SizedBox(height: 8),
              const Text(
                'Organize seu dia de forma simples.',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              AppTextField(
                label: 'E-mail',
                hint: 'seuemail@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Senha',
                hint: '••••••••',
                controller: _passwordController,
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => showComingSoon(context),
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 24),
              PrimaryButton(label: 'ENTRAR', onPressed: _login),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ainda não tem uma conta? ',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                    child: const Text(
                      'Criar conta',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.check, size: 20, color: Colors.white),
        ),
        const SizedBox(width: 8),
        const Text(
          'Taskly',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
