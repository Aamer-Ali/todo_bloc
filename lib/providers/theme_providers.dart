import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Theme provider..
class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

const Color _darkAppbarColor = Color(0xFF1C1C1C);
const Color _lightAppbarColor = Color(0xFFFFFFFF);
const Color primaryColor = Color(0xFFA0C9E5);

//Dark App Bar Style
const _darkAppBar = AppBarTheme(
    color: _darkAppbarColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: _darkAppBarTitleTextStyle);

//Light Appbar Style
final _lightAppBar = AppBarTheme(
    backgroundColor: _lightAppbarColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: _lightAppBarTitleTextStyle);

//Light Appbar Title Text Style
final _lightAppBarTitleTextStyle =
    TextStyle(color: Colors.grey.shade900, fontSize: 20);

//Dark Appbar Title Text Style
const _darkAppBarTitleTextStyle = TextStyle(color: Colors.white, fontSize: 20);

//Light Theme
final lightTheme = ThemeData(
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: _lightAppBar);

//Dark Theme
final darkTheme = ThemeData(
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: _darkAppBar);

//SubHeading Text Style
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
}

//Heading Text Style
TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}

//Title Text Style
TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold));
}
