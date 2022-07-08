import 'package:flutter/material.dart';

import 'package:vuelos_fl/src/screens/screens.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  LoginScreen.routeName: (_) => const LoginScreen(),
  HomeTabScreen.routeName: (_) => const HomeTabScreen()
};