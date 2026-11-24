import 'package:flutter/material.dart';

const _months = [
  'janeiro',
  'fevereiro',
  'março',
  'abril',
  'maio',
  'junho',
  'julho',
  'agosto',
  'setembro',
  'outubro',
  'novembro',
  'dezembro',
];

String _twoDigits(int value) => value.toString().padLeft(2, '0');

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Ex.: 15/09/2026
String formatShortDate(DateTime date) {
  return '${_twoDigits(date.day)}/${_twoDigits(date.month)}/${date.year}';
}

/// Ex.: 15 de setembro de 2026
String formatLongDate(DateTime date) {
  return '${date.day} de ${_months[date.month - 1]} de ${date.year}';
}

/// Ex.: 14:00
String formatTime(TimeOfDay time) {
  return '${_twoDigits(time.hour)}:${_twoDigits(time.minute)}';
}

/// Rótulo usado para agrupar tarefas por dia ("Hoje", "Amanhã"...).
String dayGroupLabel(DateTime date, {DateTime? now}) {
  final today = now ?? DateTime.now();
  if (isSameDay(date, today)) return 'Hoje';
  if (isSameDay(date, today.add(const Duration(days: 1)))) return 'Amanhã';
  if (isSameDay(date, today.subtract(const Duration(days: 1)))) return 'Ontem';
  return formatShortDate(date);
}
