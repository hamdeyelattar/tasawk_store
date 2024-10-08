import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawk/src/core/common/widgets/admin_app_bar.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/delete_category/bloc/delete_category_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/get_all_admin_category_bloc/bloc/get_all_admin_categories_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/refactors/add_categories_body.dart';
import 'package:tasawk/src/injector.dart';

class AddCategoriessScreen extends StatelessWidget {
  const AddCategoriessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetAllAdminCategoriesBloc>()
            ..add(
              const GetAllAdminCategoriesEvent.fetchAdminCategories(
                isNotLoading: true,
              ),
            ),
        ),
        BlocProvider(create: (context) => sl<DeleteCategoryBloc>()),
      ],
      child: const Scaffold(
        backgroundColor: ColorsDark.mainColor,
        appBar: AdminAppBar(
          isMain: true,
          backgroundColor: ColorsDark.mainColor,
          title: 'Add Categories',
        ),
        body: AddCategoriesBody(),
      ),
    );
  }
}
