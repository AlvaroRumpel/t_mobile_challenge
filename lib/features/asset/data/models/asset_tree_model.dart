class AssetTreeModel {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  List<AssetTreeModel>? children;

  AssetTreeModel({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.children,
  });

  AssetType get type {
    if (sensorType != null) {
      return AssetType.component;
    }

    if (parentId != null) {
      return AssetType.subAsset;
    }

    return AssetType.asset;
  }

  SensorType get sensorTypeEnum => SensorType.fromString(sensorType ?? '');
}

enum AssetType {
  component,
  asset,
  subAsset,
}

enum SensorType {
  energy,
  vibration;

  static SensorType fromString(String sensor) {
    switch (sensor) {
      case 'energy':
        return SensorType.energy;
      case 'vibration':
        return SensorType.vibration;
      default:
        return SensorType.vibration;
    }
  }
}
