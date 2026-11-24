import 'package:flutter/material.dart';

import 'models/task.dart';
import 'routes.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell.dart';
import 'screens/my_tasks_screen.dart';
import 'screens/new_task_screen.dart';
import 'screens/register_screen.dart';
import 'screens/task_details_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TasklyApp());
}

class TasklyApp extends StatelessWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.home: (_) => const MainShell(),
        AppRoutes.newTask: (_) => const NewTaskScreen(),
        AppRoutes.taskDetails: (_) => const TaskDetailsScreen(),
        AppRoutes.categoryTasks: (context) => MyTasksScreen(
              category:
                  ModalRoute.of(context)!.settings.arguments as TaskCategory,
            ),
      },
    );
  }
}
