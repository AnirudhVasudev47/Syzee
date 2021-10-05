import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syzee/global/color.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = ThemeMode.system == ThemeMode.dark ? true : false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ColorScheme kColorScheme = ColorScheme(
    primary: ThemeColors.primaryColorLight,
    primaryVariant: ThemeColors.primaryColorLight,
    secondary: ThemeColors.prime,
    secondaryVariant: ThemeColors.prime,
    surface: ThemeColors.backgroundColorLight,
    background: ThemeColors.backgroundColorLight,
    error: ThemeColors.errorColor,
    onPrimary: ThemeColors.dividerColor,
    onSurface: ThemeColors.dividerColor,
    onBackground: ThemeColors.dividerColor,
    onError: ThemeColors.errorColor,
    brightness: Brightness.light,
    onSecondary: ThemeColors.prime,
  );

  static IconThemeData _customIconTheme(IconThemeData original) {
    return original.copyWith(color: ThemeColors.primaryColorLight);
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base
        .copyWith(
      headline1: TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.w700,
        color: ThemeColors.headLineText1Light,
        // height: 45.h,
      ),
      headline2: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w600,
        color: ThemeColors.headLineText1Light,
      ),
      headline3: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: ThemeColors.headLineText1Light,
      ),
      headline4: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ThemeColors.headLineText1Light,
      ),
      headline5: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ThemeColors.headLineText1Light,
      ),
      headline6: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ThemeColors.headLineText1Light,
      ),
      bodyText1: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ThemeColors.headLineText1Light,
      ),
      bodyText2: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: ThemeColors.headLineText1Light,
      ),
      button: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ThemeColors.headLineText1Light,
      ),
      caption: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ThemeColors.headLineText1Light,
      ),
      subtitle1: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: ThemeColors.headLineText1Light,
      ),
      subtitle2: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ThemeColors.headLineText1Light,
      ),
      overline: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: ThemeColors.headLineText1Light,
      ),
    )
        .apply(fontFamily: 'Poppins');
  }

  static ThemeData get lightTheme {
    final base = ThemeData.light();
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: kColorScheme,
      backgroundColor: ThemeColors.backgroundColorLight,
      primaryColor: ThemeColors.primaryColorLight,
      primaryColorLight: ThemeColors.primaryColorLight,
      primaryColorDark: ThemeColors.primaryColorLight,
      accentColor: ThemeColors.primaryColorLight,
      buttonColor: ThemeColors.primaryColorLight,
      cardColor: ThemeColors.primaryColorLight,
      errorColor: ThemeColors.errorColor,
      iconTheme: _customIconTheme(base.iconTheme),
      primaryIconTheme: _customIconTheme(base.iconTheme),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      hintColor: ThemeColors.hintTextColor,
      indicatorColor: ThemeColors.primaryColorLight,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: UnderlineInputBorder(),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.errorColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primaryColorLight),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primaryColorLight),
        ),
        alignLabelWithHint: true,
        fillColor: ThemeColors.white,
        hintStyle: _buildTextTheme(base.textTheme).button!.copyWith(
          color: ThemeColors.hintTextColor,
        ),
        labelStyle: _buildTextTheme(base.textTheme).button!.copyWith(
          color: ThemeColors.headLineText1Light,
        ),
      ),
      scaffoldBackgroundColor: ThemeColors.backgroundColorLight,
      appBarTheme: AppBarTheme(
        elevation: 4,
        color: ThemeColors.headLineText1Light,
        textTheme: _buildTextTheme(base.textTheme),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size(double.minPositive, double.minPositive),
          primary: ThemeColors.primaryColorLight,
          padding: EdgeInsets.all(0),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: Colors.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.minPositive, double.minPositive),
          onPrimary: ThemeColors.primaryColorLight,
          primary: ThemeColors.primaryColorLight,
          textStyle: base.textTheme.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(double.minPositive, double.minPositive),
          elevation: 0,
          side: BorderSide(
            color: ThemeColors.primaryColorLight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          textStyle: base.textTheme.button,
        ),
      ),
      buttonTheme: base.buttonTheme.copyWith(
        minWidth: double.infinity,
        buttonColor: ThemeColors.primaryColorLight,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide.none,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.light();
    return ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: kColorScheme,
      backgroundColor: ThemeColors.backgroundColorLight,
      primaryColor: ThemeColors.primaryColorLight,
      primaryColorLight: ThemeColors.primaryColorLight,
      primaryColorDark: ThemeColors.primaryColorLight,
      accentColor: ThemeColors.primaryColorLight,
      buttonColor: ThemeColors.primaryColorLight,
      cardColor: ThemeColors.primaryColorLight,
      errorColor: ThemeColors.errorColor,
      iconTheme: _customIconTheme(base.iconTheme),
      primaryIconTheme: _customIconTheme(base.iconTheme),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      hintColor: ThemeColors.hintTextColor,
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: UnderlineInputBorder(),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.errorColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primaryColorLight),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primaryColorLight),
        ),
        alignLabelWithHint: true,
        fillColor: ThemeColors.white,
        hintStyle: _buildTextTheme(base.textTheme).bodyText1!.copyWith(
          color: ThemeColors.hintTextColor,
        ),
        labelStyle: _buildTextTheme(base.textTheme).button!.copyWith(
          color: ThemeColors.headLineText1Light,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 4,
        color: ThemeColors.headLineText1Light,
        textTheme: _buildTextTheme(base.textTheme),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size(double.minPositive, double.minPositive),
          primary: ThemeColors.primaryColorLight,
          padding: EdgeInsets.all(0),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: Colors.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.minPositive, double.minPositive),
          onPrimary: ThemeColors.primaryColorLight,
          primary: ThemeColors.primaryColorLight,
          textStyle: base.textTheme.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.minPositive, double.minPositive),
          elevation: 0,
          side: BorderSide(
            color: ThemeColors.primaryColorLight,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          textStyle: base.textTheme.button,
        ),
      ),
      buttonTheme: base.buttonTheme.copyWith(
        minWidth: double.infinity,
        buttonColor: ThemeColors.primaryColorLight,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide.none,
        ),
      ),
    );
  }
}