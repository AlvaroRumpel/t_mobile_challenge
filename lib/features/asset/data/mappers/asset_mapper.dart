import '../../domain/entities/asset.dart';
import '../models/asset_model.dart';
import '../models/asset_tree_model.dart';

Asset assetFromModel(AssetModel model) {
  return Asset(
    id: model.id,
    name: model.name,
    locationId: model.locationId,
    parentId: model.parentId,
    sensorId: model.sensorId,
    sensorType: model.sensorType,
    status: model.status,
  );
}

AssetTreeModel assetToTreeModel(Asset asset) {
  return AssetTreeModel(
    id: asset.id,
    name: asset.name,
    locationId: asset.locationId,
    parentId: asset.parentId,
    sensorId: asset.sensorId,
    sensorType: asset.sensorType,
    status: asset.status,
  );
}
