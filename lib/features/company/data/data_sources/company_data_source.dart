import '../models/company_model.dart';

abstract interface class CompanyDataSource {
  Future<List<CompanyModel>> getCompanies();
}
