import 'package:flutter/material.dart';

class AppwriteThemeFlutter {
  static ThemeData get dark => ThemeData.dark().copyWith(
        primaryColor: AppwriteColors.colorPrimary100,
        primaryColorDark: AppwriteColors.colorPrimary200,
        primaryColorLight: AppwriteColors.colorPrimary300.withAlpha(10),
        canvasColor: AppwriteColors.colorNeutral0,
        cardColor: AppwriteColors.colorBorder,
        dialogBackgroundColor: AppwriteColors.colorNeutral10,
        disabledColor: AppwriteColors.colorNeutral120,
        dividerColor: AppwriteColors.colorNeutral150,
        focusColor: AppwriteColors.colorBorder,
        scaffoldBackgroundColor: AppwriteColors.colorNeutral0,
        secondaryHeaderColor: AppwriteColors.colorPrimary200,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppwriteColors.colorPrimary100,
        ),
      );
}

// This data imported from Appwrite's Pink library

class AppwriteBorder {
  static double borderRadiusXSmall = 4;
  static double borderRadiusSmall = 8;
  static double borderRadiusMedium = 16;
  static double borderRadiusCircular = 50;
}

class AppwriteColors {
  // Brand
  static Color colorPrimary100 = const Color(0xffF02D65);
  static Color colorPrimary200 = const Color(0xffDB1A5A);
  static Color colorPrimary300 = const Color(0xffBF0D51);

  // Neutrals
  static Color colorNeutral0 = const Color(0xffFFFFFF);
  static Color colorNeutral5 = const Color(0xffFAFAFF);
  static Color colorNeutral10 = const Color(0xffF2F2F8);
  static Color colorNeutral30 = const Color(0xffE9EAF1);
  static Color colorNeutral50 = const Color(0xffC5C7D8);
  static Color colorNeutral70 = const Color(0xff858DA3);
  static Color colorNeutral100 = const Color(0xff606A7B);
  static Color colorNeutral120 = const Color(0xff4F5769);
  static Color colorNeutral150 = const Color(0xff373B4E);
  static Color colorNeutral200 = const Color(0xff27293A);
  static Color colorNeutral300 = const Color(0xff1B1B27);
  static Color colorNeutral400 = const Color(0xff161622);
  static Color colorNeutral500 = const Color(0xff14141F);

  // System Colors
  static Color colorInformation10 = const Color(0xfff1fcfe);
  static Color colorInformation50 = const Color(0xffcaeafc);
  static Color colorInformation100 = const Color(0xff00a5c2);
  static Color colorInformation120 = const Color(0xff006e85);
  static Color colorInformation200 = const Color(0xff043239);
  static Color colorSuccess10 = const Color(0xfff1fef8);
  static Color colorSuccess50 = const Color(0xffc0fcde);
  static Color colorSuccess100 = const Color(0xff00bd5e);
  static Color colorSuccess120 = const Color(0xff00754a);
  static Color colorSuccess200 = const Color(0xff06321b);
  static Color colorWarning10 = const Color(0xfffff8f0);
  static Color colorWarning50 = const Color(0xffffe1c2);
  static Color colorWarning100 = const Color(0xfff58700);
  static Color colorWarning120 = const Color(0xffb34700);
  static Color colorWarning200 = const Color(0xff462701);
  static Color colorDanger10 = const Color(0xfffff5f5);
  static Color colorDanger50 = const Color(0xffffd7d6);
  static Color colorDanger100 = const Color(0xffff4238);
  static Color colorDanger120 = const Color(0xffb51212);
  static Color colorDanger200 = const Color(0xff3f0503);

  // Additional Colors
  static Color colorBlue100 = const Color(0xffa3c5ff);
  static Color colorGreen100 = const Color(0xff94dbd2);
  static Color colorOrange100 = const Color(0xfffdc381);
  static Color colorRed100 = const Color(0xffffa3a3);
  static Color colorPurple100 = const Color(0xffcbb0fc);
  static Color colorPink100 = const Color(0xffffa3d0);

//Special Colors
  static Color colorTextDisabled = const Color(0xff606a7b);
  static Color colorTextInfo = const Color(0xff00a5c2);
  static Color colorTextDanger = const Color(0xffff4238);
  static Color colorTextWarning = const Color(0xfff58700);
  static Color colorTextSuccess = const Color(0xff00bd5e);
  static Color colorBorder = const Color(0xff27293a);
}
