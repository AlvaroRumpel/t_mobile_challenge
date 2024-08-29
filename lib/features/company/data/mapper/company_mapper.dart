import '../../domain/entities/company.dart';
import '../models/company_model.dart';

Company companyFromModel(CompanyModel model) {
  return Company(id: model.id, name: model.name);
}
