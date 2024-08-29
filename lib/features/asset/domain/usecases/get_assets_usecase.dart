import '../../data/mappers/asset_mapper.dart';
import '../../data/mappers/location_mapper.dart';
import '../../data/models/asset_tree_model.dart';
import '../../data/models/location_tree_model.dart';
import '../entities/asset.dart';
import '../entities/location.dart';
import '../repositories/asset_repository.dart';
import '../repositories/location_repository.dart';

class GetLocationAndAssetsUsecase {
  final AssetRepository _assetRepository;
  final LocationRepository _locationRepository;

  GetLocationAndAssetsUsecase({
    required AssetRepository assetRepository,
    required LocationRepository locationRepository,
  })  : _assetRepository = assetRepository,
        _locationRepository = locationRepository;

  Future<List<LocationTreeModel>> call(String companyId) async {
    final [
      locationList as List<Location>,
      assetList as List<Asset>,
    ] = await Future.wait([
      _locationRepository.getLocations(companyId),
      _assetRepository.getAssets(companyId),
    ]);

    final locationParent =
        locationList.where((e) => e.parentId == null).toList();
    final locationChildren =
        locationList.where((e) => e.parentId != null).toList();
    final locationsMap = <String, LocationTreeModel>{};

    for (final parent in locationParent) {
      locationsMap.addAll({parent.id: locationToTreeModel(parent)});
    }

    for (final locationChild in locationChildren) {
      final child = locationToTreeModel(locationChild);

      if (locationsMap.containsKey(child.parentId)) {
        locationsMap[child.parentId]?.children = [
          ...locationsMap[child.parentId]?.children ?? [],
          child,
        ];
      }
    }

    final assetParent = assetList.where((e) => e.parentId == null).toList();
    final assetChildren = assetList.where((e) => e.parentId != null).toList();
    final assetsChildrenRest = <Asset>[];
    final assetsMap = <String, AssetTreeModel>{};

    for (final parent in assetParent) {
      assetsMap.addAll({parent.id: assetToTreeModel(parent)});
    }

    for (final assetChild in assetChildren) {
      final child = assetToTreeModel(assetChild);

      if (assetsMap.containsKey(child.parentId)) {
        assetsMap[child.parentId]?.children = [
          ...assetsMap[child.parentId]?.children ?? [],
          child,
        ];

        continue;
      }

      assetsChildrenRest.add(assetChild);
    }

    for (final rest in assetsChildrenRest) {
      final child = assetToTreeModel(rest);

      for (final asset in assetsMap.values) {
        if (asset.children != null &&
            asset.children!.any((e) => e.id == child.parentId)) {
          final parent =
              asset.children!.firstWhere((e) => e.id == child.parentId);
          parent.children = [...parent.children ?? [], child];
        }
      }
    }

    for (final asset in assetsMap.values) {
      if (asset.locationId == null) {
        locationsMap.addAll({
          asset.id: LocationTreeModel(
            id: asset.id,
            name: asset.name,
            assets: [asset],
          ),
        });
      }

      if (locationsMap.containsKey(asset.locationId)) {
        locationsMap[asset.locationId]!.assets = [
          ...locationsMap[asset.locationId]!.assets ?? [],
          asset,
        ];

        continue;
      }

      for (final location in locationsMap.values) {
        if (location.children != null &&
            location.children!.any((e) => e.id == asset.locationId)) {
          final parent =
              location.children!.firstWhere((e) => e.id == asset.locationId);
          parent.assets = [...parent.assets ?? [], asset];
        }
      }
    }

    return locationsMap.values.toList();
  }
}
