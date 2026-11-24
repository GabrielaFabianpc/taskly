import 'package:flutter/material.dart';

/// Rolagem que ocupa a altura toda da tela: permite usar Spacer
/// para empurrar o botão para baixo e ainda rolar quando o teclado abre.
class FillScrollView extends StatelessWidget {
  const FillScrollView({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - padding.vertical,
            ),
            child: IntrinsicHeight(child: child),
          ),
        );
      },
    );
  }
}
