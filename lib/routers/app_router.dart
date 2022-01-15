import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/pages/add_task/add_task_page.dart';
import 'package:todo_bloc/pages/home/home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case "/add-task":
        return MaterialPageRoute(builder: (_) => AddTaskPage());
        break;
      default:
        return null;
    }
  }
}
