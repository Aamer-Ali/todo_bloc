import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloc/helper/database_helper/database/task_database.dart';
import 'package:todo_bloc/helper/database_helper/repository/task_repository.dart';
import 'package:todo_bloc/pages/home/bloc/home_bloc.dart';
import 'package:todo_bloc/pages/home/home_page.dart';
import 'package:todo_bloc/providers/theme_providers.dart';
import 'package:todo_bloc/routers/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await DBHelper.initDb();
  await TaskDatabase.instance.database;
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
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<TaskRepository>(
                  create: (context) => TaskRepository()),
            ],
            child: MultiBlocProvider(
              providers: <BlocProvider<dynamic>>[
                BlocProvider<HomeBloc>(
                    create: (context) => HomeBloc(RepositoryProvider.of<TaskRepository>(context))),
              ],
              child: MaterialApp(
                title: 'Flutter Demo',
                themeMode: themeProvider.themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                onGenerateRoute: _appRouter.onGenerateRoute,
              ),
            ),
          );
        });
  }
}
