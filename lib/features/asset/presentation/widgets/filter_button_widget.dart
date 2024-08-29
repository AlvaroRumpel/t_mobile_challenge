import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/theme_colors.dart';

class FilterButtonWidget extends StatelessWidget {
  final bool selected;
  final Widget icon;
  final String text;

  const FilterButtonWidget({
    super.key,
    required this.selected,
    required this.icon,
    required this.text,
  });

  Widget get _icon {
    if (icon is Icon) {
      final newIcon = icon as Icon;

      return Icon(
        newIcon.icon,
        size: 16,
        color: selected ? Colors.white : ThemeColors.filterContent,
      );
    }

    if (icon is SvgPicture) {
      final newIcon = icon as SvgPicture;

      return SvgPicture(
        newIcon.bytesLoader,
        height: 16,
        colorFilter: ColorFilter.mode(
          selected ? Colors.white : ThemeColors.filterContent,
          BlendMode.srcIn,
        ),
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      avatar: _icon,
      selected: selected,
      label: Text(
        text,
        style: selected ? const TextStyle(color: Colors.white) : null,
      ),
      onSelected: (_) {},
    );
  }
}
