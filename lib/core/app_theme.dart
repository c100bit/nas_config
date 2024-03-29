import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_config/core/constants.dart';

class AppTheme {
  final BuildContext _context;

  AppTheme(this._context);

  ThemeData current() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: colorSchemeSeed,
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
        focusColor: focusColor,
        radioTheme: RadioTheme.of(_context).copyWith(
          fillColor: MaterialStateProperty.all(textColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(mainBtnTextColor),
            backgroundColor: MaterialStateProperty.all(mainBtnColor),
            surfaceTintColor: MaterialStateProperty.all(secondaryColor),
            overlayColor: MaterialStateProperty.all(mainBtnHoverColor),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgColor,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardTheme.of(_context).copyWith(
          color: secondaryColor,
          margin: const EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            bottom: defaultMargin,
          ),
        ),
        textTheme: _textTheme,
      );

  TextTheme get _textTheme =>
      GoogleFonts.latoTextTheme(Theme.of(_context).textTheme.copyWith(
          bodyText2: const TextStyle(color: textColor, fontSize: bodyTextSize),
          caption: const TextStyle(color: textColor, fontSize: captionSize),
          button: const TextStyle(color: Colors.blue, fontSize: btnFontSize)));
}
