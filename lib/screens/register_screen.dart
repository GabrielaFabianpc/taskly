import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import '../widgets/fill_scroll_view.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Sem backend: ao criar a conta, limpa a pilha e abre a Home.
  void _register() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FillScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenHeader(title: 'Criar conta'),
              const SizedBox(height: 16),
              const Text(
                'Comece a organizar sua rotina com o Taskly.',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Nome completo',
                hint: 'Digite seu nome',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              AppTextField(
                label: 'Confirmar senha',
                hint: '••••••••',
                controller: _confirmPasswordController,
                isPassword: true,
              ),
              const Spacer(),
              const SizedBox(height: 24),
              PrimaryButton(label: 'CRIAR CONTA', onPressed: _register),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Já possui uma conta? ',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Entrar',
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
