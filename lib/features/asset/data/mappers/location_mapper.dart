import '../../domain/entities/location.dart';
import '../models/location_model.dart';
import '../models/location_tree_model.dart';

Location locationFromModel(LocationModel model) {
  return Location(
    id: model.id,
    name: model.name,
    parentId: model.parentId,
  );
}

LocationTreeModel locationToTreeModel(Location location) {
  return LocationTreeModel(
    id: location.id,
    name: location.name,
    parentId: location.parentId,
  );
}
