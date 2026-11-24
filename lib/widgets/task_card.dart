import 'package:flutter/material.dart';

import '../models/task.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'status_badge.dart';

/// Card de tarefa usado na Home e em Minhas tarefas.
/// Ao tocar, abre os detalhes da tarefa.
class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.taskDetails,
            arguments: task.id,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(width: 20, child: Center(child: _leading())),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: task.isDone
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                          decoration:
                              task.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            task.category.icon,
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${task.category.label} • ${formatTime(task.time)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      PriorityBadge(priority: task.priority),
                    ],
                  ),
                ),
                if (task.isDone) const DoneBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _leading() {
    if (task.isDone) {
      return Container(
        width: 18,
        height: 18,
        decoration: const BoxDecoration(
          color: AppColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 12, color: Colors.white),
      );
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: task.priority.color,
        shape: BoxShape.circle,
      ),
    );
  }
}
