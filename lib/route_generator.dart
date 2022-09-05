import 'package:flutter/material.dart';
import 'package:gwentboard/views/board_full.dart';
import 'package:gwentboard/views/capture.dart';
import 'package:gwentboard/views/home.dart';
import 'package:gwentboard/views/info.dart';
import 'package:gwentboard/views/packs.dart';
import 'package:gwentboard/views/settings.dart';
import 'package:gwentboard/views/board_half.dart';

class RoutePaths {
  static const String home = '/';
  static const String singleBoard = '/single';
  static const String fullBoard = '/full';
  static const String info = '/info';
  static const String packs = '/packs';
  static const String capture = '/capture';
  static const String settings = '/settings';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case RoutePaths.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutePaths.singleBoard:
        return MaterialPageRoute(builder: (_) => const SingleBoardPage());
      case RoutePaths.fullBoard:
        return MaterialPageRoute(builder: (_) => const FullBoardPage());
      case RoutePaths.info:
        return MaterialPageRoute(builder: (_) => const InfoPage());
      case RoutePaths.packs:
        return MaterialPageRoute(builder: (_) => const PacksPage());
      case RoutePaths.capture:
        return MaterialPageRoute(builder: (_) => const CapturePage());
      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      // Default
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR 404'),
        ),
      );
    });
  }
}
