import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_web3_games/core/gen/lng_keys/codegen_loader.g.dart';
import 'package:flutter_web3_games/core/pubs/adaptiveTheme/cupertino_adaptive_theme.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter_web3_games/view/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/consts.dart';
import '../../core/pubs/adaptiveTheme/adaptive_theme.dart';
import '../widgets/app_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPageStater();
}

class SettingsPageStater extends State<SettingsPage> {
  String selectedTheme = SharedStore.getTheme();
  List<String> themes = [LocaleKeys.light, LocaleKeys.dark, LocaleKeys.system];
  String selectedLanguage = SharedStore.getLanguage();
  List<String> languages = [LocaleKeys.en, LocaleKeys.fa];
  String selectedFont = SharedStore.getFont();
  String selected1Font = SharedStore.getFont();
  List<String> fonts = [LocaleKeys.ubuntu, LocaleKeys.anjoman];
  String selectedAppStyle = SharedStore.getAppStyle();
  List<String> appStyles = [LocaleKeys.material, LocaleKeys.cupertino];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: AppBar(
        title: Text(LocaleKeys.settings).tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // THEME ----------------------------------------------
            SizedBox(height: 10),
            Text(LocaleKeys.theme, style: TextStyle(fontSize: 20)).tr(),
            SizedBox(height: 15),
            Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(themes[0]).tr(),
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          value: themes[0],
                          groupValue: selectedTheme,
                          onChanged: (value) {
                              selectedTheme = value!;
                              SharedStore.setTheme(value);
                              if(isAppStyleMaterial()){
                                AdaptiveTheme.of(context).setLight();
                              }else{
                                CupertinoAdaptiveTheme.of(context).setLight();
                              }
                            },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(themes[1]).tr(),
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          value: themes[1],
                          groupValue: selectedTheme,
                          onChanged: (value) {
                              selectedTheme = value!;
                              SharedStore.setTheme(value);
                              if(isAppStyleMaterial()){
                                AdaptiveTheme.of(context).setDark();
                              }else{
                                CupertinoAdaptiveTheme.of(context).setDark();
                              }
                            },
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(themes[2]).tr(),
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          value: themes[2],
                          groupValue: selectedTheme,
                          onChanged: (value) {
                              selectedTheme = value!;
                              SharedStore.setTheme(value);
                              if(isAppStyleMaterial()){
                                AdaptiveTheme.of(context).setSystem();
                              }else{
                                CupertinoAdaptiveTheme.of(context).setSystem();
                              }
                            },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Divider(),
            // LANGUAGE ----------------------------------------------
            SizedBox(height: 10),
            Text(LocaleKeys.language, style: TextStyle(fontSize: 20)).tr(),
            SizedBox(height: 15),
            Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(languages[0]).tr(),
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          value: languages[0],
                          groupValue: selectedLanguage,
                          onChanged: (value) async {
                            selectedLanguage = value!;
                            SharedStore.setLanguage(value);
                            await context.setLocale(languageEn);
                            Get.updateLocale(languageEn);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(languages[1]).tr(),
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          value: languages[1],
                          groupValue: selectedLanguage,
                          onChanged: (value) async {
                            selectedLanguage = value!;
                            SharedStore.setLanguage(value);
                            await context.setLocale(languageFa);
                            Get.updateLocale(languageFa);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Divider(),
            // Font ----------------------------------------------
            SizedBox(height: 10),
            Text(LocaleKeys.font, style: TextStyle(fontSize: 20)).tr(),
            SizedBox(height: 15),
            Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(fonts[0]).tr(),
                        Radio<String>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue),
                            focusColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue),
                            value: fonts[0],
                            groupValue: selectedFont,
                            onChanged: (value) => setState(() {
                                  selectedFont = value!;
                                  SharedStore.setFont(value);
                                })),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(fonts[1]).tr(),
                        Radio<String>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue),
                            focusColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue),
                            value: fonts[1],
                            groupValue: selectedFont,
                            onChanged: (value) => setState(() {
                                  selectedFont = value!;
                                  SharedStore.setFont(value);
                                  Get.forceAppUpdate();
                                })),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (selectedFont != selected1Font)
                      Text(LocaleKeys.fontChangeNotice).tr(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),

            Divider(),
            // Font ----------------------------------------------
            SizedBox(height: 10),
            Text(LocaleKeys.appStyle, style: TextStyle(fontSize: 20)).tr(),
            SizedBox(height: 15),
            Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(appStyles[0]).tr(),
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          value: appStyles[0],
                          groupValue: selectedAppStyle,
                          onChanged: (value)
                          // => setState(()
                          {
                              selectedAppStyle = value!;
                              SharedStore.setAppStyle(value);
                              Get.forceAppUpdate();
                            },
                          // ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(appStyles[1]).tr(),
                        Radio<String>(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          focusColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue),
                          value: appStyles[1],
                          groupValue: selectedAppStyle,
                          onChanged: (value)
                          // => setState(()
                            {
                              selectedAppStyle = value!;
                              SharedStore.setAppStyle(value);
                              Get.forceAppUpdate();
                            },
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            // Font ----------------------------------------------
            SizedBox(height: 15),
            Center(
              child: FittedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Automatic download new app version", style: TextStyle(fontSize: 17)).tr(),
                        SizedBox(width: 10),
                        AppSwitch(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
