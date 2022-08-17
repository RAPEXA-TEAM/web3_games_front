// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "welcome": "Welcome",
  "games": "Games",
  "hubs": "Hubs",
  "events": "Events",
  "aboutUs": "About Us",
  "light": "Light",
  "dark": "Dark",
  "system": "System",
  "fa": "Persian",
  "en": "English",
  "ubuntu": "Ubuntu",
  "anjoman": "Anjoman",
  "material": "Material(Android)",
  "cupertino": "Cupertino(iOS)",
  "settings": "Settings",
  "theme": "Theme",
  "language": "Language",
  "font": "Font",
  "appStyle": "App Style",
  "fontChangeNotice": "This option will take effect after restarting the app",
  "gender": {
    "male": "Hi man ;) ",
    "female": "Hello girl :)",
    "with_arg": {
      "male": "Hi man ;) {}",
      "female": "Hello girl :) {}"
    }
  }
};
static const Map<String,dynamic> fa = {
  "welcome": "خوش آمدید",
  "games": "گیم ها",
  "hubs": "مراکز",
  "events": "رویداد ها",
  "aboutUs": "درباره ما",
  "light": "روشن",
  "dark": "تیره",
  "system": "سیستم",
  "fa": "فارسی",
  "en": "English",
  "ubuntu": "اوبونتو مونو",
  "anjoman": "انجمن",
  "material": "متریال(اندروید)",
  "cupertino": "کوپرتینو(آی او اس)",
  "settings": "تنظیمات",
  "theme": "تم",
  "language": "زبان",
  "font": "فونت",
  "appStyle": "ظاهر برنامه",
  "fontChangeNotice": "این آپشن بعد از ریستارت شدن برنامه اعمال میشود",
  "gender": {
    "male": "Hi man ;) ",
    "female": "Hello girl :)",
    "with_arg": {
      "male": "Hi man ;) {}",
      "female": "Hello girl :) {}"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fa": fa};
}
