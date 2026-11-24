import 'package:flutter/material.dart';

import '../data/task_store.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/screen_header.dart';
import '../widgets/selectable_chip.dart';
import '../widgets/status_badge.dart';

/// Formulário de criação de tarefa. Se receber uma [Task] como argumento
/// da rota, funciona como edição.
class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Task? _editingTask;
  DateTime _date = DateUtils.dateOnly(DateTime.now());
  TimeOfDay _time = const TimeOfDay(hour: 14, minute: 0);
  TaskCategory _category = TaskCategory.studies;
  TaskPriority _priority = TaskPriority.high;
  bool _initialized = false;

  bool get _isEditing => _editingTask != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final task = ModalRoute.of(context)?.settings.arguments as Task?;
    if (task == null) return;

    _editingTask = task;
    _titleController.text = task.title;
    _descriptionController.text = task.description;
    _date = task.date;
    _time = task.time;
    _category = task.category;
    _priority = task.priority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  void _save() {
    final messenger = ScaffoldMessenger.of(context);
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Informe o título da tarefa.')),
        );
      return;
    }

    final editingTask = _editingTask;
    if (editingTask != null) {
      taskStore.update(editingTask.copyWith(
        title: title,
        description: _descriptionController.text.trim(),
        date: _date,
        time: _time,
        category: _category,
        priority: _priority,
      ));
    } else {
      taskStore.add(Task(
        id: taskStore.generateId(),
        title: title,
        description: _descriptionController.text.trim(),
        date: _date,
        time: _time,
        category: _category,
        priority: _priority,
      ));
    }

    Navigator.pop(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(_isEditing ? 'Tarefa atualizada!' : 'Tarefa criada!'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                children: [
                  ScreenHeader(
                    title: _isEditing ? 'Editar tarefa' : 'Nova tarefa',
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Título da tarefa',
                    hint: 'Ex: Estudar Flutter',
                    controller: _titleController,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Descrição',
                    hint: 'Adicione uma descrição...',
                    controller: _descriptionController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _PickerField(
                          label: 'Data',
                          icon: Icons.calendar_today_outlined,
                          value: formatShortDate(_date),
                          onTap: _pickDate,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _PickerField(
                          label: 'Horário',
                          icon: Icons.access_time,
                          value: formatTime(_time),
                          onTap: _pickTime,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const FieldLabel('Categoria'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final category in TaskCategory.values)
                        SelectableChip(
                          label: category.label,
                          icon: category.icon,
                          selected: category == _category,
                          onTap: () => setState(() => _category = category),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const FieldLabel('Prioridade'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final priority in TaskPriority.values)
                        SelectableChip(
                          label: priority.label,
                          dotColor: priority.color,
                          selected: priority == _priority,
                          onTap: () => setState(() => _priority = priority),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: PrimaryButton(
                label: _isEditing ? 'SALVAR ALTERAÇÕES' : 'CRIAR TAREFA',
                onPressed: _save,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Campo que abre o seletor de data ou de horário.
class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.icon,
    required this.value,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label),
        const SizedBox(height: 6),
        Material(
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.border),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
              child: Row(
                children: [
                  Icon(icon, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(value, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
