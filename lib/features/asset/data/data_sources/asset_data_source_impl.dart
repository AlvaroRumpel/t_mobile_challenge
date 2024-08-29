import '../../../../core/exceptions/exception.dart';
import '../../../../core/services/http_service.dart';
import '../../../../core/services/http_service_impl.dart';
import '../models/asset_model.dart';
import 'asset_data_source.dart';

class AssetDataSourceImpl implements AssetDataSource {
  final HttpService _client = HttpServiceImpl.i;

  @override
  Future<List<AssetModel>> getAssets(String companyId) async {
    final response = await _client.get('companies/$companyId/assets');

    if (response.isEmpty) {
      throw RegisterNotFoundException('Nenhum ativo encontrado');
    }

    final assets = <AssetModel>[];
    for (final item in response) {
      assets.add(AssetModel.fromMap(item));
    }

    return assets;
  }
}
