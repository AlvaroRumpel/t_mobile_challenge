import 'asset_tree_model.dart';

class LocationTreeModel {
  final String id;
  final String name;
  final String? parentId;
  List<LocationTreeModel>? children;
  List<AssetTreeModel>? assets;

  LocationTreeModel({
    required this.id,
    required this.name,
    this.parentId,
    this.children,
    this.assets,
  });

  bool get isAsset =>
      assets != null && assets!.isNotEmpty && id == assets!.first.id;
  bool get isComponent => isAsset && assets!.first.type == AssetType.component;
}
