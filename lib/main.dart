import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloc/pages/home/home_page.dart';
import 'package:todo_bloc/providers/theme_providers.dart';
import 'package:todo_bloc/routers/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            onGenerateRoute: _appRouter.onGenerateRoute,
          );
        });
  }
}
