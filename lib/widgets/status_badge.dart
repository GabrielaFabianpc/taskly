import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme/app_theme.dart';

/// Cores de cada prioridade, conforme o protótipo.
extension TaskPriorityColors on TaskPriority {
  Color get color => switch (this) {
        TaskPriority.high => AppColors.danger,
        TaskPriority.medium => const Color(0xFFB26A00),
        TaskPriority.low => AppColors.success,
      };

  Color get badgeBackground => switch (this) {
        TaskPriority.high => const Color(0xFFFDE2E2),
        TaskPriority.medium => const Color(0xFFFFF1C2),
        TaskPriority.low => AppColors.successLight,
      };

  Color get badgeForeground => switch (this) {
        TaskPriority.high => const Color(0xFFC62828),
        TaskPriority.medium => const Color(0xFF8A6100),
        TaskPriority.low => const Color(0xFF1B7A43),
      };
}

/// Etiqueta pequena e colorida (prioridade, "Concluída"...).
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key, required this.priority});

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      text: '${priority.label} prioridade',
      background: priority.badgeBackground,
      foreground: priority.badgeForeground,
    );
  }
}

class DoneBadge extends StatelessWidget {
  const DoneBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatusBadge(
      text: 'Concluída',
      background: AppColors.successLight,
      foreground: Color(0xFF1B7A43),
    );
  }
}
