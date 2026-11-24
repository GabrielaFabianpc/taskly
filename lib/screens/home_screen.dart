import 'package:flutter/material.dart';

import '../data/task_store.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/task_card.dart';
import '../widgets/user_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onSeeAll});

  /// Troca para a aba "Tarefas" ao tocar em "Ver todas".
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.newTask),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: taskStore,
          builder: (context, _) {
            final todayTasks = taskStore.todayTasks;
            final doneCount = todayTasks.where((task) => task.isDone).length;

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, Gabriela!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Vamos organizar seu dia?',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    UserAvatar(),
                  ],
                ),
                const SizedBox(height: 20),
                _ProgressCard(done: doneCount, total: todayTasks.length),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tarefas de hoje',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: onSeeAll,
                      child: const Text(
                        'Ver todas',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (todayTasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: Center(
                      child: Text(
                        'Nenhuma tarefa para hoje.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                for (final task in todayTasks)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TaskCard(task: task),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Card roxo com o percentual de tarefas concluídas no dia.
class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.done, required this.total});

  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0.0 : done / total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Seu progresso hoje',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$done de $total tarefas concluídas',
                      style:
                          const TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Text(
                '${(percent * 100).round()}%',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 6,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
