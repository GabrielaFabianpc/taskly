import 'package:flutter/material.dart';

/// Categorias disponíveis para uma tarefa.
enum TaskCategory {
  studies('Estudos', Icons.menu_book_outlined),
  work('Trabalho', Icons.work_outline),
  personal('Pessoal', Icons.home_outlined),
  health('Saúde', Icons.favorite_border);

  const TaskCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

/// Níveis de prioridade de uma tarefa.
enum TaskPriority {
  low('Baixa'),
  medium('Média'),
  high('Alta');

  const TaskPriority(this.label);

  final String label;
}

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    required this.priority,
    this.isDone = false,
  });

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final TaskCategory category;
  final TaskPriority priority;
  final bool isDone;

  Task copyWith({
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? time,
    TaskCategory? category,
    TaskPriority? priority,
    bool? isDone,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
    );
  }
}
