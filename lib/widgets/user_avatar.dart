import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Avatar da usuária com a inicial do nome.
/// Para usar a foto do protótipo, troque o child por um Image.asset.
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.radius = 22});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primaryLight,
      child: Text(
        'G',
        style: TextStyle(
          fontSize: radius * 0.8,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
