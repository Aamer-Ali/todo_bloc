import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_bloc/providers/theme_providers.dart';

AppBar myAppBar(BuildContext context, String title) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return AppBar(
    title: Text(title),
    actions: [
      Switch.adaptive(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            final provider =
                Provider.of<ThemeProvider>(context, listen: false);
            provider.toggleTheme(value);
          }),
    ],
  );
}
