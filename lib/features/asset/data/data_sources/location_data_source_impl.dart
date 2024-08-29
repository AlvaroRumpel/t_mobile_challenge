import '../../../../core/exceptions/exception.dart';
import '../../../../core/services/http_service.dart';
import '../../../../core/services/http_service_impl.dart';
import '../models/location_model.dart';
import 'location_data_source.dart';

class LocationDataSourceImpl implements LocationDataSource {
  final HttpService _client = HttpServiceImpl.i;

  @override
  Future<List<LocationModel>> getLocations(String companyId) async {
    final response = await _client.get('companies/$companyId/locations');

    if (response.isEmpty) {
      throw RegisterNotFoundException('Nenhuma locação encontrado');
    }

    final locations = <LocationModel>[];
    for (final item in response) {
      locations.add(LocationModel.fromMap(item));
    }

    return locations;
  }
}
