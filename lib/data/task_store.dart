import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/formatters.dart';

/// Guarda as tarefas em memória (o trabalho não exige backend).
/// As telas escutam as mudanças com ListenableBuilder.
class TaskStore extends ChangeNotifier {
  TaskStore() {
    _tasks.addAll(_seedTasks());
  }

  final List<Task> _tasks = [];
  int _nextId = 100;

  /// Tarefas ordenadas por data e horário.
  List<Task> get tasks {
    final sorted = [..._tasks];
    sorted.sort((a, b) {
      final byDate = DateUtils.dateOnly(a.date).compareTo(
        DateUtils.dateOnly(b.date),
      );
      if (byDate != 0) return byDate;
      return _minutes(a.time).compareTo(_minutes(b.time));
    });
    return List.unmodifiable(sorted);
  }

  List<Task> get todayTasks {
    final now = DateTime.now();
    return tasks.where((task) => isSameDay(task.date, now)).toList();
  }

  Task? findById(String id) {
    for (final task in _tasks) {
      if (task.id == id) return task;
    }
    return null;
  }

  String generateId() => '${_nextId++}';

  void add(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void update(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
    notifyListeners();
  }

  void toggleDone(String id) {
    final task = findById(id);
    if (task == null) return;
    update(task.copyWith(isDone: !task.isDone));
  }

  int countByCategory(TaskCategory category) {
    return _tasks.where((task) => task.category == category).length;
  }

  int doneCountByCategory(TaskCategory category) {
    return _tasks
        .where((task) => task.category == category && task.isDone)
        .length;
  }

  int _minutes(TimeOfDay time) => time.hour * 60 + time.minute;

  /// Dados iniciais iguais aos do protótipo, com datas relativas a hoje.
  List<Task> _seedTasks() {
    final today = DateUtils.dateOnly(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));
    final nextWeek = today.add(const Duration(days: 5));

    return [
      Task(
        id: '1',
        title: 'Estudar Flutter',
        description:
            'Revisar os conteúdos sobre widgets, layouts e desenvolvimento '
            'de interfaces utilizando Flutter.',
        date: today,
        time: const TimeOfDay(hour: 14, minute: 0),
        category: TaskCategory.studies,
        priority: TaskPriority.high,
      ),
      Task(
        id: '2',
        title: 'Finalizar relatório',
        description: 'Fechar os números do mês e enviar para a equipe.',
        date: today,
        time: const TimeOfDay(hour: 16, minute: 30),
        category: TaskCategory.work,
        priority: TaskPriority.medium,
      ),
      Task(
        id: '3',
        title: 'Academia',
        description: 'Treino de pernas e 20 minutos de esteira.',
        date: today,
        time: const TimeOfDay(hour: 19, minute: 0),
        category: TaskCategory.health,
        priority: TaskPriority.low,
        isDone: true,
      ),
      Task(
        id: '4',
        title: 'Revisar matéria da faculdade',
        description: 'Ler os slides da última aula e fazer os exercícios.',
        date: tomorrow,
        time: const TimeOfDay(hour: 10, minute: 0),
        category: TaskCategory.studies,
        priority: TaskPriority.medium,
      ),
      Task(
        id: '5',
        title: 'Organizar documentos',
        description: 'Separar comprovantes e digitalizar contratos.',
        date: tomorrow,
        time: const TimeOfDay(hour: 18, minute: 0),
        category: TaskCategory.personal,
        priority: TaskPriority.low,
      ),
      Task(
        id: '6',
        title: 'Reunião de planejamento',
        description: 'Alinhar as entregas da próxima sprint.',
        date: nextWeek,
        time: const TimeOfDay(hour: 9, minute: 30),
        category: TaskCategory.work,
        priority: TaskPriority.high,
      ),
    ];
  }
}

/// Instância única compartilhada pelas telas.
final taskStore = TaskStore();
