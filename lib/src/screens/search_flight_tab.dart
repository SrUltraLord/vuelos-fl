import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vuelos_fl/src/providers/search_flight_form_provider.dart';
import 'package:vuelos_fl/src/services/flight_service.dart';
import 'package:vuelos_fl/src/services/notifications_service.dart';
import 'package:vuelos_fl/src/ui/box_decorations.dart';
import 'package:vuelos_fl/src/ui/input_decorations.dart';

import '../widgets/widgets.dart';

class SearchFlightTabScreen extends StatelessWidget {
  const SearchFlightTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flightService = Provider.of<FlightService>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ChangeNotifierProvider(
                create: (_) => SearchFlightFormProvider(),
                child: const _SearchFlightForm(),
              ),
              const SizedBox(height: 16),
              (flightService.flight == null)
                  ? const BackgroundMessage(
                      icon: Icons.search_rounded,
                      text: 'Busca tu siguiente vuelo',
                    )
                  : FlightResultCard(
                      isInfoCard: false, flight: flightService.flight!),
              const SizedBox(height: 16),
              // const LoadingFlightCard(),
            ],
          ),
        ),
      )),
    );
  }
}

class _SearchFlightForm extends StatelessWidget {
  const _SearchFlightForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flightService = Provider.of<FlightService>(context);
    final searchFlightForm = Provider.of<SearchFlightFormProvider>(context);

    return Container(
      decoration: BoxDecorations.cardDecoration,
      width: double.infinity,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: searchFlightForm.formKey,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const _CitiesRow(),
                const SizedBox(height: 16),
                const _DateRange(),
                const SizedBox(height: 16),
                FormButton(
                  text: 'Buscar',
                  isLoading: flightService.isLoading,
                  onPressed: () async {
                    if (!searchFlightForm.isValidForm()) {
                      return;
                    }

                    final response = await flightService.findFlight(
                        searchFlightForm.cityOrigin,
                        searchFlightForm.cityDestination,
                        searchFlightForm.dateFrom,
                        searchFlightForm.dateTo);

                    if (response?.status == null || response?.status != 200) {
                      NotificationsService.showSnackbar(
                          response?.message ?? 'Error');
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}

class _CitiesRow extends StatelessWidget {
  const _CitiesRow({
    Key? key,
  }) : super(key: key);

  _validateCityCode(String? value) {
    if (value == null) {
      return 'Este campo es requerido';
    }

    if (value.length != 3) {
      return 'Debe tener 3 caracteres';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final searchFlight = Provider.of<SearchFlightFormProvider>(context);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            textCapitalization: TextCapitalization.characters,
            onChanged: (value) => searchFlight.cityOrigin = value,
            validator: (value) => _validateCityCode(value),
            decoration: InputDecorations.authInputDecoration(
              hintText: 'AAA',
              labelText: 'Origen',
              prefixIcon: Icons.location_pin,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: TextFormField(
            textCapitalization: TextCapitalization.characters,
            onChanged: (value) => searchFlight.cityDestination = value,
            validator: (value) => _validateCityCode(value),
            decoration: InputDecorations.authInputDecoration(
                hintText: 'BBB',
                labelText: 'Destino',
                prefixIcon: Icons.location_pin),
          ),
        )
      ],
    );
  }
}

class _DateRange extends StatelessWidget {
  const _DateRange({
    Key? key,
  }) : super(key: key);

  Future<DateTimeRange?> _getFlightDateRange(BuildContext context) async {
    final DateTimeRange? selectedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime(2022, 12, 31));

    return selectedDateRange;
  }

  @override
  Widget build(BuildContext context) {
    final searchFlightForm = Provider.of<SearchFlightFormProvider>(context);
    final fieldController = TextEditingController();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return TextFormField(
      onTap: () async {
        DateTimeRange? selectedRange = await _getFlightDateRange(context);
        if (selectedRange == null) return;

        searchFlightForm.dateFrom = formatter.format(selectedRange.start);
        searchFlightForm.dateTo = formatter.format(selectedRange.end);

        fieldController.text =
            '${searchFlightForm.dateFrom}, ${searchFlightForm.dateTo}';
      },
      controller: fieldController,
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El rango de fechas es necesario';
        }

        return null;
      },
      decoration: InputDecorations.authInputDecoration(
          hintText: 'yyyy-mm-dd, yyyy-mm-dd',
          labelText: 'Fechas del viaje',
          prefixIcon: Icons.calendar_month_outlined),
    );
  }
}
