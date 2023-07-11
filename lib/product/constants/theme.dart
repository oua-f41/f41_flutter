import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_sheme.dart';
import 'project_colors.dart';

class ThemeConsts {
  static ThemeData light = ThemeData.light(useMaterial3: true).copyWith(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineLarge: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        color: Colors.black54,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineSmall: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelLarge: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleSmall: TextStyle(
        color: Color(0xff000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelSmall: TextStyle(
        color: Color(0xff000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        color: Colors.black87,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineSmall: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        color: Color(0x8a000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelLarge: TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleSmall: TextStyle(
        color: Color(0xff000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelSmall: TextStyle(
        color: Color(0xff000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: ProjectColors.disabledColor,
        fontSize: null,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
      floatingLabelStyle: TextStyle(
        color: ProjectColors.hintColor,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: const TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: const TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: ProjectColors.errorColor,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: null,
      isDense: false,
      contentPadding: const EdgeInsets.all(15),
      isCollapsed: false,
      prefixStyle: const TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: const TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: const TextStyle(
        color: Color(0xdd000000),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: false,
      fillColor: const Color.fromARGB(10, 0, 0, 0),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.errorColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.highlightColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.highlightColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.highlightColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.highlightColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.highlightColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color(0xdd000000),
      unselectedLabelColor: Color(0xb2000000),
    ),
    dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    )),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xff4285f4),
      selectionColor: Color(0xffa5f3c3),
      selectionHandleColor: Color(0xff79eca4),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: ColorSchemes.lightColorScheme.outline.withOpacity(0.5),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
    colorScheme: ColorSchemes.lightColorScheme,
    scaffoldBackgroundColor: ColorSchemes.lightColorScheme.background,
  );

  /* *************************************************************** */

  static ThemeData dark = ThemeData.dark(useMaterial3: true).copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Colors.transparent)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineSmall: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: TextStyle(
        color: Color(0xffffffff),
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleSmall: TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelLarge: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelSmall: TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    primaryTextTheme: TextTheme(
      displayLarge: TextStyle(
        color: ProjectColors.primaryColor,
        fontSize: 50,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: const TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: const TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: const TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineSmall: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: const TextStyle(
        color: Color(0xffffffff),
        fontSize: 80,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      ),
      titleMedium: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: const TextStyle(
        color: Color(0xb3ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelLarge: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleSmall: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      labelSmall: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: Color(0x80ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      helperStyle: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      hintStyle: const TextStyle(
        color: Color(0x80ffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorStyle: TextStyle(
        color: ProjectColors.errorColor,
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      errorMaxLines: null,
      isDense: false,
      contentPadding: const EdgeInsets.all(15),
      isCollapsed: false,
      prefixStyle: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: const TextStyle(
        color: Color(0xffffffff),
        fontSize: null,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 20, 20, 20),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.errorColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.weakShadowColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.weakShadowColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.weakShadowColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.weakShadowColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ProjectColors.weakShadowColor,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color(0xffffffff),
      unselectedLabelColor: Color(0xb2ffffff),
    ),
    dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    )),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff424242)),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xff64ffda);
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return const Color(0xff64ffda);
        }
        return null;
      }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: ColorSchemes.lightColorScheme.outline.withOpacity(0.5),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
    ),
    colorScheme: ColorSchemes.darkColorScheme,
    scaffoldBackgroundColor: ColorSchemes.darkColorScheme.background,
  );
}
