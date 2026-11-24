import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/data/task_store.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/utils/formatters.dart';

void main() {
  test('formata datas em português', () {
    final date = DateTime(2026, 9, 15);
    expect(formatShortDate(date), '15/09/2026');
    expect(formatLongDate(date), '15 de setembro de 2026');
  });

  test('agrupa tarefas por dia', () {
    final now = DateTime(2026, 9, 15);
    expect(dayGroupLabel(DateTime(2026, 9, 15), now: now), 'Hoje');
    expect(dayGroupLabel(DateTime(2026, 9, 16), now: now), 'Amanhã');
  });

  test('marca e desmarca tarefa como concluída', () {
    final store = TaskStore();
    final task = store.tasks.firstWhere((item) => !item.isDone);

    store.toggleDone(task.id);
    expect(store.findById(task.id)!.isDone, isTrue);

    store.toggleDone(task.id);
    expect(store.findById(task.id)!.isDone, isFalse);
  });

  test('conta tarefas por categoria', () {
    final store = TaskStore();
    expect(store.countByCategory(TaskCategory.studies), 2);
    expect(store.doneCountByCategory(TaskCategory.health), 1);
  });
}
