import 'package:flutter/material.dart';

import '../../../../components/components.dart';
import '../../../../core/theme/theme_colors.dart';
import '../../../../core/utils/assets.dart';
import '../../domain/entities/company.dart';

class CompanyListWidget extends StatelessWidget {
  final List<Company> companies;
  final CompanyTapCallback onTapItem;
  const CompanyListWidget({
    super.key,
    required this.companies,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) {
        final company = companies[index];
        return InkWell(
          onTap: () => onTapItem(company.id),
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: ThemeColors.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Image.asset(
                  COMPANY_ICON,
                  scale: 16,
                ),
                const CustomSpace.sp4(),
                Text(
                  '${company.name} Unit',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const CustomSpace(height: 40),
      itemCount: companies.length,
    );
  }
}

typedef CompanyTapCallback = void Function(String companyId);
