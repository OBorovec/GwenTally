import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class GwentIcons {
  // Game icons
  static AssetImage scorch = const AssetImage('assets/icons/scull.png');
  // Card icons
  static IconData commanderHorn = Icons.bookmark;
  static IconData muster = Icons.group;
  static IconData tightBond = Icons.handshake;
  static IconData moral = Icons.exposure_plus_1;
  static IconData doubleMoral = Icons.exposure_plus_2;
  static IconData spy = Icons.remove_red_eye;
  static IconData hybrid = Icons.sync_outlined;
  // Weather icons
  static IconData sunny = WeatherIcons.fromString('wi-day-sunny');
  static IconData snow = WeatherIcons.fromString('wi-snow');
  static IconData fog = WeatherIcons.fromString('wi-fog');
  static IconData rain = WeatherIcons.fromString('wi-rain');
}
