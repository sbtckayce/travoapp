
import '/models/search_flight/search_flight.dart';

import '../../models/flight/flight_model.dart';

abstract class BaseFlightRepository {

 

  Stream<List<FlightModel>> getAllFlight();

  Stream<List<FlightModel>> getAllFightWhereInfoFlight(SearchFlightModel searchFlightModel);


  Stream<FlightModel> getFlightWhereFlightId(String flightId);
}