import '../../../../core/exceptions/exception.dart';
import '../../../../core/services/http_service.dart';
import '../../../../core/services/http_service_impl.dart';
import '../models/company_model.dart';
import 'company_data_source.dart';

class CompanyDataSourceImpl implements CompanyDataSource {
  final HttpService _client = HttpServiceImpl.i;

  @override
  Future<List<CompanyModel>> getCompanies() async {
    final response = await _client.get('companies');

    if (response.isEmpty) {
      throw RegisterNotFoundException('Nenhuma unidade encontrada');
    }

    final companies = <CompanyModel>[];

    for (final item in response) {
      companies.add(CompanyModel.fromMap(item));
    }

    return companies;
  }
}
