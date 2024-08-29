import '../entities/company.dart';

abstract interface class CompanyRepository {
  Future<List<Company>> getCompanies();
}
