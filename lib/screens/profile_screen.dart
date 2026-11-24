import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/feedback.dart';
import '../widgets/user_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Volta para o login e limpa a pilha de navegação.
  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const Text(
              'Perfil',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            const Center(child: UserAvatar(radius: 36)),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Gabriela',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            const Center(
              child: Text(
                'gabriela@email.com',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => showComingSoon(context),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  foregroundColor: AppColors.primary,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Editar perfil',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: AppDecorations.card,
              clipBehavior: Clip.antiAlias,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    _ProfileOption(
                      icon: Icons.notifications_none,
                      label: 'Notificações',
                      onTap: () => showComingSoon(context),
                    ),
                    const _OptionDivider(),
                    _ProfileOption(
                      icon: Icons.palette_outlined,
                      label: 'Aparência',
                      onTap: () => showComingSoon(context),
                    ),
                    const _OptionDivider(),
                    _ProfileOption(
                      icon: Icons.lock_outline,
                      label: 'Privacidade',
                      onTap: () => showComingSoon(context),
                    ),
                    const _OptionDivider(),
                    _ProfileOption(
                      icon: Icons.help_outline,
                      label: 'Ajuda',
                      onTap: () => showComingSoon(context),
                    ),
                    const _OptionDivider(),
                    _ProfileOption(
                      icon: Icons.logout,
                      label: 'Sair da conta',
                      isDestructive: true,
                      onTap: () => _logout(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.danger : AppColors.textPrimary;

    return ListTile(
      dense: true,
      onTap: onTap,
      leading: Icon(icon, size: 20, color: color),
      title: Text(label, style: TextStyle(fontSize: 13, color: color)),
      trailing: isDestructive
          ? null
          : const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.textSecondary,
            ),
    );
  }
}

class _OptionDivider extends StatelessWidget {
  const _OptionDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: AppColors.border,
    );
  }
}
