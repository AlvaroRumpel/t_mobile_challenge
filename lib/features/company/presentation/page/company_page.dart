import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/mixins/mixin.dart';
import '../bloc/company_cubit.dart';
import '../widgets/company_list_widget.dart';
import '../widgets/try_again_widget.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> with LoadingMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          LOGO,
          width: 126,
          height: 17,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: BlocConsumer<CompanyCubit, CompanyState>(
          listenWhen: (previous, current) =>
              previous is CompanyLoading || current is CompanyLoading,
          buildWhen: (previous, current) => previous is CompanyLoading,
          listener: (context, state) {
            return state.maybeWhen(
              loading: () => showLoading(context),
              orElse: () => hideLoading(),
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              initial: () => const Center(
                child: Text(
                  'Nenhuma informação foi buscada ainda, aguarde um momento...',
                  textAlign: TextAlign.center,
                ),
              ),
              success: (companies) {
                return CompanyListWidget(
                  companies: companies,
                  onTapItem: (companyId) {
                    Navigator.pushNamed(context, ASSETS, arguments: companyId);
                  },
                );
              },
              error: (message) {
                return TryAgainWidget(
                  message: message,
                  onPressed: context.read<CompanyCubit>().getCompanies,
                );
              },
              tryAgain: () => TryAgainWidget(
                message: 'Tente novamente mais tarde!',
                onPressed: context.read<CompanyCubit>().getCompanies,
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
