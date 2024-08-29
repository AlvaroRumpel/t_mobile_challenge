import '../../../../core/exceptions/exception.dart';
import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../data_sources/asset_data_source.dart';
import '../mappers/asset_mapper.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetDataSource _dataSource;

  AssetRepositoryImpl({required AssetDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<Asset>> getAssets(String companyId) async {
    try {
      final assetList = await _dataSource.getAssets(companyId);

      final assets = <Asset>[];

      for (final item in assetList) {
        assets.add(assetFromModel(item));
      }

      return assets;
    } on RegisterNotFoundException {
      rethrow;
    } catch (e) {
      throw CustomException('Error has occurred');
    }
  }
}
