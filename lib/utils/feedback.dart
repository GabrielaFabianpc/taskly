import 'package:flutter/material.dart';

/// Aviso para ações que ficam fora do escopo do trabalho (sem backend).
void showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(content: Text('Funcionalidade em breve!')),
    );
}
