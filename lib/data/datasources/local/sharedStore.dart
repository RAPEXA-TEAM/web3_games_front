import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter_web3_games/core/gen/lng_keys/codegen_loader.g.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const currentLanguage = "currentLanguage";
const currentTheme = "currentTheme";
const themeBrightness = "themeBrightness";
const currentFont = "currentFont";
const appStyle = "appStyle";
const userEmail = "userEmail";
const userToken = "userToken";
const userClashRoyaleTag = "userClashRoyaleTag";
const userName = "userName";
const registeredWalletAddress = "regWalletAddress";

class SharedStore {
  static SharedPreferences? _prefsInstance;

  static bool _enableLogging = false;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init({bool enableLogging = false}) async {
    _enableLogging = enableLogging;
    if (_prefsInstance != null) {
      return _prefsInstance!;
    } else {
      _prefsInstance = await SharedPreferences.getInstance();
      return _prefsInstance!;
    }
  }

  static Future<void>? clearUserIdentity() async {
    await _prefsInstance?.remove(userEmail);
    await _prefsInstance?.remove(userToken);
  }

  static String getString(String key, [String defValue = ""]) {
    String value = _prefsInstance!.getString(key) ?? defValue;
    if (_enableLogging) {
      debugPrint("\n KEY: $key \n GET_VALUE: $value \n");
    }
    return value;
  }

  static Future<bool> setString(String key, String value) async {
    bool result = await _prefsInstance!.setString(key, value);
    if (_enableLogging) {
      debugPrint("\n KEY: $key \n SET_VALUE: $value \n");
    }
    return result;
  }

  static bool getBool(String key, [bool defValue = false]) {
    return _prefsInstance!.getBool(key) ?? defValue;
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefsInstance!.setBool(key, value);
  }

  static getLanguage() {
    return _prefsInstance!.getString(currentLanguage) ?? LocaleKeys.en;
  }

  static setLanguage(String value) {
    return _prefsInstance!.setString(currentLanguage, value);
  }

  static getTheme() {
    return _prefsInstance!.getString(currentTheme) ?? LocaleKeys.light;
  }

  static setTheme(String value) {
    return _prefsInstance!.setString(currentTheme, value);
  }

  static getThemeBrightness() {
    return _prefsInstance!.getInt(themeBrightness) ?? 0;
  }

  static setThemeBrightness(int value) {
    return _prefsInstance!.setInt(themeBrightness, value);
  }

  static getFont() {
    return _prefsInstance!.getString(currentFont) ?? LocaleKeys.ubuntu;
  }

  static setFont(String value) {
    return _prefsInstance!.setString(currentFont, value);
  }

  static getAppStyle() {
    return _prefsInstance!.getString(appStyle) ?? LocaleKeys.material;
  }

  static setAppStyle(String value) {
    return _prefsInstance!.setString(appStyle, value);
  }

  static getUserToken() {
    return _prefsInstance!.getString(userToken) ?? "";
  }

  static setUserToken(String value) {
    return _prefsInstance!.setString(userToken, value);
  }

  static getUserEmail() {
    return _prefsInstance!.getString(userEmail) ?? "";
  }

  static setUserEmail(String value) {
    return _prefsInstance!.setString(userEmail, value);
  }

  static getUserClashRoyaleTag() {
    return _prefsInstance!.getString(userClashRoyaleTag) ?? "";
  }

  static setUserClashRoyaleTag(String value) {
    return _prefsInstance!.setString(userClashRoyaleTag, value);
  }

  static String getUserName([String defValue = ""]) {
    return getString(userName, defValue);
  }

  static Future<bool> setUserName(String value) {
    return setString(userName, value);
  }

  static String getRegisteredWalletAddress([String defValue = ""]) {
    return getString(registeredWalletAddress, defValue);
  }

  static Future<bool> setRegisteredWalletAddress(String value) {
    return setString(registeredWalletAddress, value);
  }
}
