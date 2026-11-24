import 'package:flutter/material.dart';

import '../data/task_store.dart';
import '../models/task.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/feedback.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: taskStore,
          builder: (context, _) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                const Text(
                  'Categorias',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Organize suas tarefas por assunto.',
                  style:
                      TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.25,
                  children: [
                    for (final category in TaskCategory.values)
                      _CategoryCard(
                        category: category,
                        total: taskStore.countByCategory(category),
                        done: taskStore.doneCountByCategory(category),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: TextButton.icon(
                    onPressed: () => showComingSoon(context),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text(
                      'Criar nova categoria',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
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

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.total,
    required this.done,
  });

  final TaskCategory category;
  final int total;
  final int done;

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
            AppRoutes.categoryTasks,
            arguments: category,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(category.icon, size: 22, color: AppColors.primary),
                const Spacer(),
                Text(
                  category.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$total ${total == 1 ? 'tarefa' : 'tarefas'}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '$done ${done == 1 ? 'concluída' : 'concluídas'}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
