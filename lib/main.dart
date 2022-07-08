import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuelos_fl/src/providers/ui_provider.dart';

import 'package:vuelos_fl/src/routes/app_routes.dart';
import 'package:vuelos_fl/src/screens/screens.dart';
import 'package:vuelos_fl/src/services/flight_service.dart';
import 'package:vuelos_fl/src/services/notifications_service.dart';
import 'package:vuelos_fl/src/services/ticket_service.dart';
import 'package:vuelos_fl/src/services/user_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => FlightService()),
        ChangeNotifierProvider(create: (_) => TicketService()),
        ChangeNotifierProvider(create: (_) => UserService())
      ],
      child: MaterialApp(
        scaffoldMessengerKey: NotificationsService.messengerKey,
        debugShowCheckedModeBanner: false,
        title: 'Vuelos App',
        initialRoute: LoginScreen.routeName,
        routes: appRoutes,
      ),
    );
  }
}
