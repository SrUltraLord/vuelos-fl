import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuelos_fl/src/providers/ui_provider.dart';
import 'package:vuelos_fl/src/screens/screens.dart';
import 'package:vuelos_fl/src/services/ticket_service.dart';
import 'package:vuelos_fl/src/services/user_service.dart';

class HomeTabScreen extends StatelessWidget {
  static const String routeName = 'home';

  final List<Widget> tabs = const [
    SearchFlightTabScreen(),
    MyFlightsTabScreen()
  ];

  const HomeTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return Scaffold(
      body: tabs[uiProvider.selectedTab],
      bottomNavigationBar: const _BottomNavBar(),
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({Key? key}) : super(key: key);
  final currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final ticketService = Provider.of<TicketService>(context);
    final userService = Provider.of<UserService>(context);

    return BottomNavigationBar(
      onTap: (value) {
        uiProvider.selectedTab = value;
        if (value == 1) {
          ticketService.findAllUserTickets(userService.user!.nui);
        }
      },
      currentIndex: uiProvider.selectedTab,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(uiProvider.selectedTab == 1
              ? Icons.airplane_ticket_rounded
              : Icons.airplane_ticket_outlined),
          label: 'Mis Vuelos',
        )
      ],
    );
  }
}
