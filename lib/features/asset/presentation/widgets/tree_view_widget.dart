import 'package:flutter/material.dart';

import '../../../../components/components.dart';
import '../../../../core/utils/assets.dart';
import '../../data/models/asset_tree_model.dart';
import '../../data/models/location_tree_model.dart';

class TreeViewWidget extends StatelessWidget {
  final List<LocationTreeModel> locations;
  const TreeViewWidget({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final location = locations[index];

          return (location.children != null || location.assets != null) &&
                  !location.isComponent
              ? ExpansionTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Image.asset(
                        location.isAsset
                            ? location.isComponent
                                ? COMPONENT_ICON
                                : ASSET_ICON
                            : LOCATION_ICON,
                        height: 22,
                      ),
                      const CustomSpace.sp1(),
                      Text(location.name),
                    ],
                  ),
                  children: [
                    if (location.children != null)
                      TreeViewWidget(locations: location.children!),
                    if (location.assets != null)
                      TreeAssetWidget(assets: location.assets!),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: ListTile(
                    leading: Image.asset(
                      location.isComponent ? COMPONENT_ICON : ASSET_ICON,
                      height: 22,
                    ),
                    title: Row(
                      children: [
                        const CustomSpace.sp1(),
                        Text(location.name),
                      ],
                    ),
                  ),
                );
        },
        separatorBuilder: (_, __) => const CustomSpace.sp2(),
        itemCount: locations.length,
      ),
    );
  }
}

class TreeAssetWidget extends StatelessWidget {
  final List<AssetTreeModel> assets;

  const TreeAssetWidget({super.key, required this.assets});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final asset = assets[index];

        return asset.children != null
            ? ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Row(
                  children: [
                    Image.asset(
                      asset.type == AssetType.component
                          ? COMPONENT_ICON
                          : ASSET_ICON,
                      height: 22,
                    ),
                    const CustomSpace.sp1(),
                    Text(asset.name),
                  ],
                ),
                children: [
                  if (asset.children != null)
                    TreeAssetWidget(assets: asset.children!),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ListTile(
                  leading: Image.asset(
                    asset.type == AssetType.component
                        ? COMPONENT_ICON
                        : ASSET_ICON,
                    height: 22,
                  ),
                  title: Row(
                    children: [
                      const CustomSpace.sp1(),
                      Text(asset.name),
                      Visibility(
                        visible: asset.type == AssetType.component,
                        child: Row(
                          children: [
                            const CustomSpace.sp1(),
                            Visibility(
                              visible:
                                  asset.sensorTypeEnum == SensorType.energy,
                              replacement: const Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 12,
                              ),
                              child: const Icon(
                                Icons.bolt,
                                color: Colors.green,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
      separatorBuilder: (_, __) => const CustomSpace.sp2(),
      itemCount: assets.length,
    );
  }
}
