import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Rótulo exibido acima dos campos de formulário.
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    );
  }
}

/// Campo de texto com rótulo; em modo senha mostra o botão de exibir/ocultar.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(widget.label),
        const SizedBox(height: 6),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscure,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          keyboardType: widget.keyboardType,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
