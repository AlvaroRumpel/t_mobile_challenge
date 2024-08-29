import '../models/location_model.dart';

abstract interface class LocationDataSource {
  Future<List<LocationModel>> getLocations(String companyId);
}
