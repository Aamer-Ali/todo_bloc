import 'package:flutter/material.dart';
import 'package:todo_bloc/providers/theme_providers.dart';

class MyInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final Function()? onSuffixIconTap;

  const MyInputField(
      {Key? key,
      required this.label,
      required this.hint,
      this.controller,
      this.widget,
      this.onSuffixIconTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Text(
              label,
              style: titleStyle,
            ),
          ),
          TextFormField(
            // enabled: widget == null ? true : false,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: widget != null
                  ? InkWell(
                      child: widget,
                      onTap: onSuffixIconTap,
                    )
                  : null,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
