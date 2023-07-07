import 'package:flutter/material.dart';

import 'package:weather_icons/weather_icons.dart';

const List<String> _allowedIcons = ['wi-snow', 'wi-rain', 'wi-fog'];

class WeatherIconSwitch extends StatelessWidget {
  final double size;
  final String weatherIconOn;
  final bool weatherOn;
  final Function() onTap;

  WeatherIconSwitch({
    super.key,
    required this.size,
    required this.weatherIconOn,
    required this.weatherOn,
    required this.onTap,
  }) : assert(_allowedIcons.contains(weatherIconOn));

  @override
  Widget build(BuildContext context) {
    List<Widget> weatherIcons = [
      _wrapIcon(context, weatherOn, weatherIconOn),
      _wrapIcon(context, !weatherOn, 'wi-day-sunny'),
    ];
    if (weatherOn) weatherIcons = weatherIcons.reversed.toList();

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size * 0.05,
          vertical: size * 0.05,
        ),
        child: SizedBox(
          width: size * 0.90,
          height: size * 0.90,
          child: Stack(
            children: weatherIcons,
          ),
        ),
      ),
    );
  }

  Widget _wrapIcon(BuildContext context, bool isFront, String iconID) {
    return Align(
      alignment: isFront ? Alignment.topLeft : Alignment.bottomRight,
      child: Icon(
        WeatherIcons.fromString(iconID),
        color: isFront
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.onSecondary,
        size: isFront ? size * 0.90 * (4 / 5) : size * 0.90 * (4 / 5) / 2,
      ),
    );
  }
}
