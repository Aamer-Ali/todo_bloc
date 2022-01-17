import 'package:flutter/material.dart';
import 'package:todo_bloc/model/task.dart';
import 'package:todo_bloc/providers/theme_providers.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile(
      {Key? key,
      required this.task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageWidth = MediaQuery.of(context).size.width;
    final _pageHeight = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: task.color == 1 ? Colors.blue : task.color == 2 ? Colors.pink : Colors.yellow,
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: _pageWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title.toString(),
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${task.startTime.toString()} - "),
                      Text("${task.endTime.toString()}")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                   task.note.toString() ,
                    style: titleStyle,
                  ),
                ],
              ),
              RotatedBox(
                quarterTurns: -45,
                child: Text(
                  "Todo",
                  style: titleStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
