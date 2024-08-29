import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/exception.dart';
import '../../domain/entities/company.dart';
import '../../domain/usecases/get_companies_usecase.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final GetCompaniesUsecase _getComapaniesUsecase;

  CompanyCubit({
    required GetCompaniesUsecase getComapaniesUsecase,
  })  : _getComapaniesUsecase = getComapaniesUsecase,
        super(CompanyInitial()) {
    getCompanies();
  }

  Future<void> getCompanies() async {
    try {
      emit(CompanyLoading());
      final companies = await _getComapaniesUsecase();
      emit(CompanySuccess(companies: companies));
    } on RegisterNotFoundException catch (e) {
      emit(CompanyError(message: e.toString()));
    } catch (e) {
      emit(CompanyTryAgain());
    }
  }
}
