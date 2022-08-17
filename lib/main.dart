import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_web3_games/core/pubs/adaptiveTheme/adaptive_theme.dart';
import 'package:flutter_web3_games/core/pubs/adaptiveTheme/adaptive_theme_mode.dart';
import 'package:flutter_web3_games/core/pubs/adaptiveTheme/cupertino_adaptive_theme.dart';
import 'package:flutter_web3_games/core/router.dart';
import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter_web3_games/view/widgets/toasting/overlay_state_finder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'core/binding.dart';
import 'core/consts.dart';
import 'core/gen/lng_keys/codegen_loader.g.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedStore.init();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  // doWhenWindowReady(() {
  //   const initialSize = Size(800, 600);
  //   appWindow.minSize = initialSize;
  //   appWindow.size = initialSize;
  //   appWindow.alignment = Alignment.center;
  //   appWindow.show();
  // });


  runApp(
    EasyLocalization(
      supportedLocales: [
        languageEn,
        languageFa,
      ],
      useOnlyLangCode: true,
      fallbackLocale: isLanguageFa() ? languageFa : languageEn,
      startLocale: isLanguageFa() ? languageFa : languageEn,
      path: 'assets/languages',
      child: OverlaySupport.global(
        child: App(savedThemeMode: savedThemeMode),
      ),
    ),
  );
}

class App extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const App({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AppStater();
  }
}

class AppStater extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: isAppStyleMaterial()
          ? AdaptiveTheme(
              light: ThemeData(
                brightness: Brightness.light,
                fontFamily: SharedStore.getFont(),
              ),
              dark: ThemeData(
                brightness: Brightness.dark,
                fontFamily: SharedStore.getFont(),
              ),
              initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
              builder: (theme, darkTheme) {
                return GetMaterialApp.router(
                  // initialRoute: SPLASH_ROUTE,
                  // onGenerateRoute: AppRouter().generateRoute,
                  initialBinding: AppBinding(),
                  routeInformationParser: const QRouteInformationParser(),
                  routerDelegate: QRouterDelegate(Routes.routes),
                  theme: theme,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  darkTheme: darkTheme,
                  title: tr(LocaleKeys.games),
                  builder: EasyLoading.init(),
                );
              },
            )
          : CupertinoAdaptiveTheme(
              light: CupertinoThemeData(
                brightness: Brightness.light,
              ),
              dark: CupertinoThemeData(
                brightness: Brightness.dark,
              ),
              initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
              builder: (theme) {
                return GetCupertinoApp.router(
                  // initialRoute: SPLASH_ROUTE,
                  // onGenerateRoute: AppRouter().generateRoute,
                  initialBinding: AppBinding(),
                  routeInformationParser: const QRouteInformationParser(),
                  routerDelegate: QRouterDelegate(Routes.routes),
                  theme: theme,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  // darkTheme: darkTheme,
                  title: tr(LocaleKeys.games),
                  builder: EasyLoading.init(),
                );
              },
            ),
    );
  }
}
