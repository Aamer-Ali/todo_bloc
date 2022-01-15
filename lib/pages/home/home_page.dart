import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Home Page"),
      body: SafeArea(
        child: Column(
          children: [
            _addTasks(),
            _addDateBar(context),
            TaskTile(
              title: "",
              description: "",
              startTime: "",
              endTime: "",
            ),
            TaskTile(
              title: "",
              description: "",
              startTime: "",
              endTime: "",
            ),
            TaskTile(
              title: "",
              description: "",
              startTime: "",
              endTime: "",
            ),
          ],
        ),
      ),
    );
  }

  Container _addDateBar(BuildContext context) {
    return Container(
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
            onTap: () {
              if (kDebugMode) {
                Navigator.pushNamed(context, "/add-task");
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
