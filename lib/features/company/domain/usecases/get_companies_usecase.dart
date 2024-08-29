import '../entities/company.dart';
import '../repositories/company_repository.dart';

class GetCompaniesUsecase {
  final CompanyRepository _repository;

  GetCompaniesUsecase({required CompanyRepository repository})
      : _repository = repository;

  Future<List<Company>> call() => _repository.getCompanies();
}
