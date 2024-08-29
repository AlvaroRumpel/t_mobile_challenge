import '../models/asset_model.dart';

abstract interface class AssetDataSource {
  Future<List<AssetModel>> getAssets(String companyId);
}
