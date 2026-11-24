import 'package:flutter/material.dart';

import '../data/task_store.dart';
import '../models/task.dart';
import '../routes.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/screen_header.dart';
import '../widgets/selectable_chip.dart';
import '../widgets/task_card.dart';

enum TaskFilter {
  all('Todas'),
  pending('Pendentes'),
  done('Concluídas');

  const TaskFilter(this.label);

  final String label;
}

/// Lista de tarefas agrupadas por dia, com filtros.
/// Quando recebe uma [category], mostra só as tarefas dela (aberta a
/// partir da tela de Categorias).
class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key, this.category});

  final TaskCategory? category;

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  TaskFilter _filter = TaskFilter.all;

  List<Task> _applyFilters(List<Task> tasks) {
    final category = widget.category;
    return tasks.where((task) {
      if (category != null && task.category != category) return false;
      return switch (_filter) {
        TaskFilter.all => true,
        TaskFilter.pending => !task.isDone,
        TaskFilter.done => task.isDone,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: taskStore,
          builder: (context, _) {
            final tasks = _applyFilters(taskStore.tasks);

            // As tarefas já vêm ordenadas, então os grupos seguem a ordem.
            final groups = <String, List<Task>>{};
            for (final task in tasks) {
              groups.putIfAbsent(dayGroupLabel(task.date), () => []).add(task);
            }

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              children: [
                if (category != null)
                  ScreenHeader(title: category.label)
                else
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Minhas tarefas',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      _NewTaskButton(),
                    ],
                  ),
                const SizedBox(height: 4),
                Text(
                  category == null
                      ? 'Acompanhe tudo que você precisa fazer.'
                      : 'Tarefas da categoria ${category.label}.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    for (final filter in TaskFilter.values)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SelectableChip(
                          label: filter.label,
                          selected: filter == _filter,
                          radius: 20,
                          onTap: () => setState(() => _filter = filter),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                if (tasks.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Nenhuma tarefa encontrada.',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                for (final entry in groups.entries) ...[
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final task in entry.value)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TaskCard(task: task),
                    ),
                  const SizedBox(height: 8),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NewTaskButton extends StatelessWidget {
  const _NewTaskButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.pushNamed(context, AppRoutes.newTask),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 32),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
      icon: const Icon(Icons.add, size: 16),
      label: const Text('Nova tarefa'),
    );
  }
}
