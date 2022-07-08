import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuelos_fl/src/services/ticket_service.dart';
import 'package:vuelos_fl/src/services/user_service.dart';
import 'package:vuelos_fl/src/widgets/background_message.dart';
import 'package:vuelos_fl/src/widgets/flight_result_card.dart';
import 'package:vuelos_fl/src/widgets/loading_flight_card.dart';

class MyFlightsTabScreen extends StatelessWidget {
  const MyFlightsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketService = Provider.of<TicketService>(context);

    if (ticketService.isLoading) {
      return const Scaffold(
        backgroundColor: Color.fromRGBO(238, 238, 238, 1),
        body: SafeArea(child: _LoadingTicketsList()),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: SafeArea(
          child: (ticketService.tickets.isEmpty)
              ? const BackgroundMessage(
                  text: 'No tienes tickets comprados',
                  icon: Icons.remove_shopping_cart_outlined)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ticketService.tickets.length,
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: FlightResultCard(
                            isInfoCard: true,
                            flight: ticketService.tickets[i].flight,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16)
                    ],
                  ),
                )),
    );
  }
}

class _LoadingTicketsList extends StatelessWidget {
  const _LoadingTicketsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: LoadingFlightCard(),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: LoadingFlightCard(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
