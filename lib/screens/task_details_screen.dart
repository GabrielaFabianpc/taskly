import 'package:flutter/material.dart';

import '../data/task_store.dart';
import '../models/task.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_header.dart';
import '../widgets/status_badge.dart';

/// Detalhes de uma tarefa. Recebe o id da tarefa como argumento da rota
/// e escuta o store para refletir edições e a mudança de status.
class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: taskStore,
          builder: (context, _) {
            final task = taskStore.findById(taskId);
            if (task == null) {
              return const Center(child: Text('Tarefa não encontrada.'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    children: [
                      const ScreenHeader(title: 'Detalhes da tarefa'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _CategoryTag(category: task.category),
                          if (task.isDone) ...[
                            const SizedBox(width: 8),
                            const DoneBadge(),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task.description.isEmpty
                            ? 'Sem descrição.'
                            : task.description,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: AppDecorations.card,
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.calendar_today_outlined,
                              label: 'Data',
                              value: Text(formatLongDate(task.date)),
                            ),
                            const Divider(height: 1, color: AppColors.border),
                            _InfoRow(
                              icon: Icons.access_time,
                              label: 'Horário',
                              value: Text(formatTime(task.time)),
                            ),
                            const Divider(height: 1, color: AppColors.border),
                            _InfoRow(
                              icon: Icons.flag_outlined,
                              label: 'Prioridade',
                              value: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: task.priority.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    task.priority.label,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: task.priority.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AppRoutes.newTask,
                            arguments: task,
                          ),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text('EDITAR'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      PrimaryButton(
                        label: task.isDone
                            ? 'MARCAR COMO PENDENTE'
                            : 'MARCAR COMO CONCLUÍDA',
                        icon: task.isDone ? Icons.undo : Icons.check,
                        onPressed: () => taskStore.toggleDone(task.id),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CategoryTag extends StatelessWidget {
  const _CategoryTag({required this.category});

  final TaskCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(category.icon, size: 12, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            category.label.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 13)),
          const Spacer(),
          DefaultTextStyle.merge(
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            child: value,
          ),
        ],
      ),
    );
  }
}
