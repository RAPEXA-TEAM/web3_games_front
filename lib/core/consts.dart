import 'dart:ui';

import 'package:flutter_web3_games/data/datasources/local/sharedStore.dart';
import 'package:flutter/material.dart';

enum ReqStatus {
  success,
  loading,
  error,
  initial,
}

enum TransactionState {
  disconnected,
  connecting,
  connected,
  connectionFailed,
  transferring,
  success,
  failed,
}

Locale languageEn = const Locale('en');
Locale languageFa = const Locale("fa");
bool isLanguageEn(){
  return SharedStore.getLanguage() == "en";
}
bool isLanguageFa(){
  return SharedStore.getLanguage() == "fa";
}

bool isAppStyleMaterial(){
  return SharedStore.getAppStyle() == "material";
}
bool isAppStyleCupertino(){
  return SharedStore.getAppStyle() == "Cupertino";
}


