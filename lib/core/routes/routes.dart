import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/asset/data/data_sources/asset_data_source.dart';
import '../../features/asset/data/data_sources/asset_data_source_impl.dart';
import '../../features/asset/data/data_sources/location_data_source.dart';
import '../../features/asset/data/data_sources/location_data_source_impl.dart';
import '../../features/asset/data/repositories/asset_repository_impl.dart';
import '../../features/asset/data/repositories/location_repository_impl.dart';
import '../../features/asset/domain/repositories/asset_repository.dart';
import '../../features/asset/domain/repositories/location_repository.dart';
import '../../features/asset/domain/usecases/get_assets_usecase.dart';
import '../../features/asset/presentation/bloc/asset_cubit.dart';
import '../../features/asset/presentation/page/asset_page.dart';
import '../../features/company/data/data_sources/company_data_source.dart';
import '../../features/company/data/data_sources/company_data_source_impl.dart';
import '../../features/company/data/repositories/company_repository_impl.dart';
import '../../features/company/domain/repositories/company_repository.dart';
import '../../features/company/domain/usecases/get_companies_usecase.dart';
import '../../features/company/presentation/bloc/company_cubit.dart';
import '../../features/company/presentation/page/company_page.dart';

part 'routes_names.dart';

final routes = <String, Widget Function(BuildContext)>{
  // SPLASH: (_) => const SplashPage(),
  COMPANY: (_) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CompanyDataSource>(
            create: (_) => CompanyDataSourceImpl(),
          ),
          RepositoryProvider<CompanyRepository>(
            create: (context) => CompanyRepositoryImpl(
              dataSource: context.read<CompanyDataSource>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => GetCompaniesUsecase(
              repository: context.read<CompanyRepository>(),
            ),
          ),
        ],
        child: BlocProvider(
          create: (context) => CompanyCubit(
            getComapaniesUsecase: context.read<GetCompaniesUsecase>(),
          ),
          child: const CompanyPage(),
        ),
      ),

  ASSETS: (_) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LocationDataSource>(
            create: (_) => LocationDataSourceImpl(),
          ),
          RepositoryProvider<AssetDataSource>(
            create: (_) => AssetDataSourceImpl(),
          ),
          RepositoryProvider<LocationRepository>(
            create: (context) => LocationRepositoryImpl(
              dataSource: context.read<LocationDataSource>(),
            ),
          ),
          RepositoryProvider<AssetRepository>(
            create: (context) => AssetRepositoryImpl(
              dataSource: context.read<AssetDataSource>(),
            ),
          ),
          RepositoryProvider(
            create: (context) => GetLocationAndAssetsUsecase(
              assetRepository: context.read<AssetRepository>(),
              locationRepository: context.read<LocationRepository>(),
            ),
          ),
        ],
        child: BlocProvider(
          create: (context) => AssetCubit(
            getLocationsAndAssetsUsecase:
                context.read<GetLocationAndAssetsUsecase>(),
          ),
          child: const AssetPage(),
        ),
      ),
};
