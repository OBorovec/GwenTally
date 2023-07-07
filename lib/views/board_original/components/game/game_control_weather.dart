import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gwentboard/views/board_original/components/game/bloc/game_bloc.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:gwentboard/views/board_original/board_sizer.dart';

abstract class WeatherIconSwitch extends StatelessWidget {
  final String weatherIconOn;
  final String weatherIconOff;

  const WeatherIconSwitch({
    Key? key,
    required this.weatherIconOn,
    required this.weatherIconOff,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final bool isOn = _isOn(state);
        List<Widget> weatherIcons = [
          _wrapIcon(context, isOn, weatherIconOn),
          _wrapIcon(context, !isOn, weatherIconOff),
        ];
        if (isOn) weatherIcons = weatherIcons.reversed.toList();
        return InkWell(
          onTap: () {
            _onTap(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  context.read<BoardSizer>().controlIconPaddingHorizontal,
              vertical: context.read<BoardSizer>().controlIconPaddingVertical,
            ),
            child: SizedBox(
              height: context.read<BoardSizer>().controlIconSize * (5 / 4),
              width: context.read<BoardSizer>().controlIconSize * (4 / 3),
              child: Stack(
                children: weatherIcons,
              ),
            ),
          ),
        );
      },
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
        size: isFront
            ? context.read<BoardSizer>().controlIconSize
            : context.read<BoardSizer>().controlIconSize / 2,
      ),
    );
  }

  bool _isOn(GameState state);

  void _onTap(BuildContext context);
}

class FrostWeatherSwitch extends WeatherIconSwitch {
  const FrostWeatherSwitch({
    Key? key,
  }) : super(
          key: key,
          weatherIconOn: 'wi-snow',
          weatherIconOff: 'wi-day-sunny',
        );

  @override
  bool _isOn(GameState state) {
    return state.isFrost;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<GameBloc>(context).add(ToggleFrostWeather());
  }
}

class FogWeatherSwitch extends WeatherIconSwitch {
  const FogWeatherSwitch({
    Key? key,
  }) : super(
          key: key,
          weatherIconOn: 'wi-fog',
          weatherIconOff: 'wi-day-sunny',
        );

  @override
  bool _isOn(GameState state) {
    return state.isFog;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<GameBloc>(context).add(ToggleFogWeather());
  }
}

class RainWeatherSwitch extends WeatherIconSwitch {
  const RainWeatherSwitch({
    Key? key,
  }) : super(
          key: key,
          weatherIconOn: 'wi-rain',
          weatherIconOff: 'wi-day-sunny',
        );

  @override
  bool _isOn(GameState state) {
    return state.isRain;
  }

  @override
  void _onTap(BuildContext context) {
    BlocProvider.of<GameBloc>(context).add(ToggleRainWeather());
  }
}
