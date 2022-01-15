import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/helper/database_helper/db_helper.dart';
import 'package:todo_bloc/model/task.dart';
import 'package:todo_bloc/providers/theme_providers.dart';
import 'package:todo_bloc/widgets/my_app_bar.dart';
import 'package:todo_bloc/widgets/my_button.dart';
import 'package:todo_bloc/widgets/my_input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  int _selectedReminder = 5;
  List<int> reminderList = [5, 10, 15, 20];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int _selectedColor = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Add Task"),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              MyInputField(
                label: "Title",
                hint: "Enter title here",
                controller: _titleTextController,
              ),
              MyInputField(
                label: "Note",
                hint: "Enter note here",
                controller: _noteTextController,
              ),
              MyInputField(
                label: "Date",
                hint: DateFormat.yMMMMd().format(_selectedDate),
                widget: const Icon(Icons.calendar_today),
                onSuffixIconTap: _getDateFromUser,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: MyInputField(
                      label: "Start Time",
                      hint: _startTime,
                      widget: const Icon(Icons.watch_later_outlined),
                      onSuffixIconTap: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: MyInputField(
                      label: "End Time",
                      hint: _endTime,
                      widget: const Icon(Icons.watch_later_outlined),
                      onSuffixIconTap: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                    ),
                  ),
                ],
              ),
              MyInputField(
                label: "Reminder",
                hint: "$_selectedReminder minutes early",
                widget: DropdownButton(
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedReminder = int.parse(newValue!);
                    });
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: reminderList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem<String>(
                        value: e.toString(), child: Text(e.toString()));
                  }).toList(),
                ),
              ),
              MyInputField(
                label: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: repeatList.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem<String>(
                        value: e.toString(), child: Text(e.toString()));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallete(),
                  MyButton(
                    label: "Create Task",
                    onTap: _validateFormData,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateFormData() async {
    if (_titleTextController.text.isNotEmpty &&
        _noteTextController.text.isNotEmpty) {
      int val = await DBHelper.insert(Task(
          title: _titleTextController.text,
          note: _noteTextController.text,
          isCompleted: 0,
          date: DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          color: _selectedColor,
          reminder: _selectedReminder,
          repeat: _selectedRepeat));
      print("Task Added to $val");
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("All fields are required"),
      ));
    }
  }

  Container _colorPallete() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Color",
            style: titleStyle,
          ),
          Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = 1;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.blue,
                    child: _selectedColor == 1
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = 2;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.pink,
                    child: _selectedColor == 2
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = 3;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.yellow,
                    child: _selectedColor == 3
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      // print("No Date selected");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(
          hour: 9,
          minute: 10,
        ),
        initialEntryMode: TimePickerEntryMode.input);
    if (_pickedTime != null) {
      if (isStartTime) {
        setState(() {
          _startTime = _pickedTime.format(context);
        });
      } else {
        _endTime = _pickedTime.format(context);
      }
    }
  }
}
