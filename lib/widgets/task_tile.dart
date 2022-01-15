import 'package:flutter/material.dart';
import 'package:todo_bloc/providers/theme_providers.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String description;
  final String startTime;
  final String endTime;

  const TaskTile(
      {Key? key,
      required this.title,
      required this.description,
      required this.startTime,
      required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageWidth = MediaQuery.of(context).size.width;
    final _pageHeight = MediaQuery.of(context).size.height;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blue,
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
                    "Hi",
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
                      Text("9:434 PM - "),
                      Text("9:434 PM")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
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
