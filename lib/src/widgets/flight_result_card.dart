import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vuelos_fl/src/models/flight.dart';
import 'package:vuelos_fl/src/services/flight_service.dart';
import 'package:vuelos_fl/src/services/notifications_service.dart';
import 'package:vuelos_fl/src/services/ticket_service.dart';
import 'package:vuelos_fl/src/services/user_service.dart';
import 'package:vuelos_fl/src/ui/box_decorations.dart';

class FlightResultCard extends StatelessWidget {
  final bool isInfoCard;
  final Flight flight;

  const FlightResultCard(
      {Key? key, required this.flight, required this.isInfoCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorations.cardDecoration,
      child: Column(
        children: [
          _TitleRow(isInfoCard: isInfoCard, flight: flight),
          Container(
            height: 16,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: const Divider(
              height: 2,
              color: Colors.black54,
            ),
          ),
          _CitiesRow(flight: flight),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  final bool isInfoCard;
  final Flight flight;

  const _TitleRow({
    Key? key,
    required this.flight,
    required this.isInfoCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    final flightService = Provider.of<FlightService>(context);
    final ticketService = Provider.of<TicketService>(context);

    return Row(
      children: [
        Text(
          flight.number,
          style: TextStyle(
              color: Colors.blue[900],
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text('\$ ${flight.cost}')),
        if (!isInfoCard)
          TextButton(
              onPressed: () async {
                if (userService.user == null || flightService.flight == null) {
                  return;
                }

                final response = await ticketService.buyTicket(
                    userService.user!.userId, flightService.flight!.id);

                if (response?.ok == null || !response!.ok) {
                  return;
                }

                flightService.deleteFlight();
                NotificationsService.showSnackbar(response.message);
              },
              child: Row(
                children: const [
                  Icon(Icons.shopping_cart_outlined),
                  SizedBox(width: 2),
                  Text('Comprar'),
                ],
              ))
      ],
    );
  }
}

class _CitiesRow extends StatelessWidget {
  const _CitiesRow({
    Key? key,
    required this.flight,
  }) : super(key: key);

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ColumnItem(
          title: flight.cityOrigin,
          body: 'Origen',
        ),
        Expanded(
            child: Column(
          children: [
            const _AirplaneIcon(),
            Text(
              flight.dateDeparture,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(flight.timeDeparture)
          ],
        )),
        _ColumnItem(
          title: flight.cityDestination,
          body: 'Destino',
        )
      ],
    );
  }
}

class _AirplaneIcon extends StatelessWidget {
  const _AirplaneIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: const [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Divider(
          thickness: 2,
          color: Colors.black12,
        ),
      ),
      RotatedBox(
        quarterTurns: 1,
        child: Icon(
          Icons.airplanemode_active_rounded,
          size: 64,
          color: Colors.blueAccent,
        ),
      ),
    ]);
  }
}

class _ColumnItem extends StatelessWidget {
  final String title;
  final String body;

  const _ColumnItem({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              body,
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            )
          ],
        ),
      ],
    );
  }
}
