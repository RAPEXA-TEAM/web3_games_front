

import 'package:flutter_web3_games/core/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIcons{
  static getHome(){
    return !isAppStyleMaterial() ? CupertinoIcons.home : Icons.home;
  }
  static getSetting(){
    return !isAppStyleMaterial() ? CupertinoIcons.settings : Icons.settings;
  }
  static getHubs(){
    return !isAppStyleMaterial() ? CupertinoIcons.map_fill : Icons.map_rounded;
  }
  static getEvents(){
    return !isAppStyleMaterial() ? CupertinoIcons.calendar_badge_plus : Icons.calendar_today_sharp;
  }
  static getAboutUs(){
    return !isAppStyleMaterial() ? CupertinoIcons.wand_rays_inverse : Icons.whatshot_outlined;
  }
  static getWallet(){
    return !isAppStyleMaterial() ? CupertinoIcons.creditcard_fill : Icons.account_balance_wallet_rounded;
  }
  static getDecks(){
    return !isAppStyleMaterial() ? CupertinoIcons.calendar_circle : Icons.style;
  }
  static getBattle(){
    return !isAppStyleMaterial() ? CupertinoIcons.burn : CupertinoIcons.burn;
  }
  static getPlayer(){
    return !isAppStyleMaterial() ? CupertinoIcons.person : Icons.person;
  }
  static getClans(){
    return !isAppStyleMaterial() ? CupertinoIcons.group_solid : Icons.group;
  }
  static getCards(){
    return !isAppStyleMaterial() ? CupertinoIcons.app_fill : Icons.padding;
  }
  static getEsport(){
    return !isAppStyleMaterial() ? CupertinoIcons.game_controller_solid : Icons.videogame_asset_rounded;
  }
  static getPersonCheck(){
    return !isAppStyleMaterial() ? CupertinoIcons.person_crop_circle_fill_badge_checkmark : CupertinoIcons.person_crop_circle_fill_badge_checkmark;
  }
  static getPersonNotCheck(){
    return !isAppStyleMaterial() ? CupertinoIcons.person_crop_circle_fill : CupertinoIcons.person_crop_circle_fill;
  }
  static getLogout(){
    return !isAppStyleMaterial() ? CupertinoIcons.square_arrow_left : Icons.logout;
  }
  static getRefresh(){
    return !isAppStyleMaterial() ? CupertinoIcons.refresh : Icons.refresh;
  }
  static getPen(){
    return !isAppStyleMaterial() ? CupertinoIcons.pen : Icons.edit;
  }
}