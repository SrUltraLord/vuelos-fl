import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:vuelos_fl/src/environment/constants.dart';
import 'package:vuelos_fl/src/models/responses/buy_ticket_response.dart';
import 'package:vuelos_fl/src/models/responses/user_tickets_response.dart';
import 'package:vuelos_fl/src/models/ticket.dart';
import 'package:vuelos_fl/src/services/notifications_service.dart';

class TicketService extends ChangeNotifier {
  final serverUrl = Constants.serverUrl;

  bool isLoading = false;
  List<Ticket> tickets = [];

  Future<BuyTicketResponse?> buyTicket(int userId, int flightId) async {
    isLoading = true;
    notifyListeners();

    final Map<String, int> buyTicketData = {
      'userId': userId,
      'flightId': flightId
    };

    try {
      final url = Uri.http(serverUrl, 'ticket/buy');
      final resp = await http.post(url,
          body: jsonEncode(buyTicketData),
          headers: {'content-type': 'application/json'});

      final buyTicketResponse = buyTicketResponseFromJson(resp.body);
      return buyTicketResponse;
    } catch (e) {
      NotificationsService.showSnackbar('Algo ha salido mal');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UserTicketsResponse?> findAllUserTickets(String userNui) async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.http(serverUrl, 'ticket/user/$userNui');
      final resp =
          await http.get(url, headers: {'content-type': 'application/json'});

      final userTicketsResponse = userTicketsResponseFromJson(resp.body);

      tickets = userTicketsResponse.data;
      notifyListeners();

      return userTicketsResponse;
    } catch (e) {
      NotificationsService.showSnackbar('Algo ha salido mal');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
