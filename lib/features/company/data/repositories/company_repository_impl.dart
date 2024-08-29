import '../../../../core/exceptions/exception.dart';
import '../../domain/entities/company.dart';
import '../../domain/repositories/company_repository.dart';
import '../data_sources/company_data_source.dart';
import '../mapper/company_mapper.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDataSource _dataSource;

  CompanyRepositoryImpl({required CompanyDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<List<Company>> getCompanies() async {
    try {
      final companiesList = await _dataSource.getCompanies();

      final companies = <Company>[];

      for (final item in companiesList) {
        companies.add(companyFromModel(item));
      }

      return companies;
    } on RegisterNotFoundException {
      rethrow;
    } catch (e) {
      throw CustomException('Error has occurred');
    }
  }
}
