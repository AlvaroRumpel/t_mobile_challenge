import '../entities/location.dart';

abstract interface class LocationRepository {
  Future<List<Location>> getLocations(String companyId);
}
