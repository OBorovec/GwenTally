import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class GwentIcons {
  // Game icons
  static const AssetImage scorch = AssetImage('assets/icons/scull.png');
  static const AssetImage crown = AssetImage('assets/icons/crown.png');
  // Card icons
  static const AssetImage commanderHorn = AssetImage('assets/icons/horn.png');
  // static IconData commanderHorn = Icons.bookmark;
  static const IconData muster = Icons.group;
  static const IconData tightBond = Icons.handshake;
  static const IconData moral = Icons.exposure_plus_1;
  static const IconData doubleMoral = Icons.exposure_plus_2;
  static const IconData spy = Icons.remove_red_eye;
  static const IconData hybrid = Icons.sync_outlined;
  // Weather icons
  static IconData sunny = WeatherIcons.fromString('wi-day-sunny');
  static IconData snow = WeatherIcons.fromString('wi-snow');
  static IconData fog = WeatherIcons.fromString('wi-fog');
  static IconData rain = WeatherIcons.fromString('wi-rain');
}
