import '../../../../core/exceptions/exception.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../data_sources/location_data_source.dart';
import '../mappers/location_mapper.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource _dataSource;

  LocationRepositoryImpl({required LocationDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<Location>> getLocations(String companyId) async {
    try {
      final locationList = await _dataSource.getLocations(companyId);

      final locations = <Location>[];

      for (final item in locationList) {
        locations.add(locationFromModel(item));
      }

      return locations;
    } on RegisterNotFoundException {
      rethrow;
    } catch (e) {
      throw CustomException('Error has occurred');
    }
  }
}
