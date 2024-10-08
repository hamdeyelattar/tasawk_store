import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawk/src/core/common/widgets/admin_app_bar.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/categories_number/categories_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/products_number/products_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/users_number/users_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/refactors/dashboard_body.dart';
import 'package:tasawk/src/injector.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<ProductsNumberBloc>()..add(const GetProductsNumberEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<CategoriesNumberBloc>()..add(const GetCategoriesNumberEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<UsersNumberBloc>()..add(const GetUsersNumberEvent()),
        ),
      ],
      child: const Scaffold(
        backgroundColor: ColorsDark.mainColor,
        appBar: AdminAppBar(
          isMain: true,
          backgroundColor: ColorsDark.mainColor,
          title: 'DashBoard',
        ),
        body: DashboardBody(),
      ),
    );
  }
}
