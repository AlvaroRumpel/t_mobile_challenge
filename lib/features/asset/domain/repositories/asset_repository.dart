import '../entities/asset.dart';

abstract interface class AssetRepository {
  Future<List<Asset>> getAssets(String companyId);
}
