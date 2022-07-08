import 'package:flutter/material.dart';
import 'package:vuelos_fl/src/environment/constants.dart';
import 'package:vuelos_fl/src/models/flight.dart';
import 'package:vuelos_fl/src/models/responses/flight_response.dart';
import 'package:vuelos_fl/src/services/notifications_service.dart';
import 'package:http/http.dart' as http;

class FlightService extends ChangeNotifier {
  final serverUrl = Constants.serverUrl;

  bool isLoading = false;
  Flight? flight;

  Future<FlightResponse?> findFlight(String cityOrigin, String cityDestination,
      String dateFrom, String dateTo) async {
    flight = null;
    isLoading = true;
    notifyListeners();

    final Map<String, String> flightData = {
      'cityOrigin': cityOrigin,
      'cityDestination': cityDestination,
      'dateFrom': dateFrom,
      'dateTo': dateTo
    };

    try {
      final url = Uri.http(serverUrl, 'flight/search', flightData);
      final resp =
          await http.get(url, headers: {'content-type': 'application/json'});

      FlightResponse flightResponse = flightResponseFromJson(resp.body);
      flight = flightResponse.data;
      notifyListeners();

      return flightResponse;
    } catch (e) {
      NotificationsService.showSnackbar('Algo ha salido mal');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  deleteFlight() {
    flight = null;
    notifyListeners();
  }
}
