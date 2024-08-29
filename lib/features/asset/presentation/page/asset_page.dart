import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../components/components.dart';
import '../../../../core/theme/theme_colors.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/mixins/loading_mixin.dart';
import '../bloc/asset_cubit.dart';
import '../widgets/filter_button_widget.dart';
import '../widgets/tree_view_widget.dart';

class AssetPage extends StatefulWidget {
  const AssetPage({super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> with LoadingMixin {
  @override
  void didChangeDependencies() {
    context.read<AssetCubit>().getLocationsAndAssetsUsecase(
          ModalRoute.of(context)!.settings.arguments as String,
        );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchBar(
                  hintText: 'Buscar Ativo ou Local',
                  leading: Icon(
                    Icons.search,
                    color: ThemeColors.searchBarContent,
                  ),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                ),
                Row(
                  children: [
                    FilterButtonWidget(
                      selected: false,
                      text: 'Sensor de Energia',
                      icon: SvgPicture.asset(BOLT_ICON),
                    ),
                    const CustomSpace.sp2(),
                    const FilterButtonWidget(
                      selected: false,
                      text: 'Crítico',
                      icon: Icon(Icons.error_outline_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          BlocConsumer<AssetCubit, AssetState>(
            listenWhen: (previous, current) =>
                previous is AssetLoading || current is AssetLoading,
            buildWhen: (previous, current) => previous is AssetLoading,
            listener: (context, state) {
              return state.maybeWhen(
                loading: () => showLoading(context),
                orElse: () => hideLoading(),
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                success: (locations) => Expanded(
                  child: SingleChildScrollView(
                    child: TreeViewWidget(locations: locations),
                  ),
                ),
                orElse: () => const Text('Erro'),
              );
            },
          ),
        ],
      ),
    );
  }
}
