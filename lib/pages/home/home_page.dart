import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:todo_bloc/helper/database_helper/repository/task_repository.dart';
import 'package:todo_bloc/pages/home/bloc/home_bloc.dart';
import 'package:todo_bloc/providers/theme_providers.dart';
import 'package:todo_bloc/widgets/my_app_bar.dart';
import 'package:todo_bloc/widgets/my_button.dart';
import 'package:todo_bloc/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadTaskFromDataBaseEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Home Page"),
      body: SafeArea(
        child: Column(
          children: [
            _addTasks(),
            _addDateBar(context),
            BlocProvider(
              create: (context) =>
                  HomeBloc(RepositoryProvider.of<TaskRepository>(context))
                    ..add(LoadTaskFromDataBaseEvent()),
              child: Expanded(
                flex: 1,
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is HomeLoadedState || state is HomeDataNotFound) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please Have alook")));
                    }
                  },
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeLoadedState) {
                      return RefreshIndicator(
                        onRefresh: _getData,
                        child: ListView.builder(
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              return TaskTile(
                                task: state.tasks[index],
                              );
                            }),
                      );
                    }
                    if (state is HomeDataNotFound) {
                      return const Center(
                        child: Text("There is no data to show right now..."),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getData() async {
    BlocProvider.of<HomeBloc>(context).add(LoadTaskFromDataBaseEvent());
  }

  Widget _addDateBar(BuildContext context) {
    return Expanded(
      flex: MediaQuery.of(context).orientation == Orientation.landscape ? 1 : 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: DatePicker(
          DateTime.now(),
          height: MediaQuery.of(context).size.height / 9,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryColor,
          selectedTextColor: Colors.white,
          monthTextStyle: _datePickerTextStyle(context),
          dayTextStyle: _datePickerTextStyle(context),
          dateTextStyle: _datePickerTextStyle(context),
          onDateChange: (date) {
            _selectedDate = date;
          },
        ),
      ),
    );
  }

  TextStyle _datePickerTextStyle(BuildContext context) {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            color:
                Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black));
  }

  Container _addTasks() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
            label: " + Add Task",
            onTap: () async {
              if (kDebugMode) {
                final data = await Navigator.pushNamed(context, "/add-task");
                if (data == true) {
                  BlocProvider.of<HomeBloc>(context).add(LoadTaskById());
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyle() =>
      const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
}
