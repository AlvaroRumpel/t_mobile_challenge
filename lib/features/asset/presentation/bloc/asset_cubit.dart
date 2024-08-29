import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/location_tree_model.dart';
import '../../domain/usecases/get_assets_usecase.dart';

part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  final GetLocationAndAssetsUsecase _getLocationsAndAssetsUsecase;

  AssetCubit({
    required GetLocationAndAssetsUsecase getLocationsAndAssetsUsecase,
  })  : _getLocationsAndAssetsUsecase = getLocationsAndAssetsUsecase,
        super(AssetInitial());

  Future<void> getLocationsAndAssetsUsecase(String companyId) async {
    try {
      emit(AssetLoading());
      final locations = await _getLocationsAndAssetsUsecase(companyId);
      emit(AssetSuccess(locations: locations));
    } catch (e) {
      emit(AssetError(message: e.toString()));
    }
  }
}
