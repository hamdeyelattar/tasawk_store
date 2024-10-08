import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawk/src/core/common/widgets/admin_app_bar.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/delete_product/bloc/delete_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/get_all_admin_product/bloc/get_all_admin_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/refactors/add_products_body.dart';
import 'package:tasawk/src/injector.dart';

class AddProductsScreen extends StatelessWidget {
  const AddProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetAllAdminProductBloc>()
            ..add(
              const GetAllAdminProductEvent.getAllProducts(
                isNotLoading: true,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => sl<DeleteProductBloc>(),
        ),
      ],
      child: const Scaffold(
        backgroundColor: ColorsDark.mainColor,
        appBar: AdminAppBar(
          isMain: true,
          backgroundColor: ColorsDark.mainColor,
          title: 'Add Products',
        ),
        body: AddProductsBody(),
      ),
    );
  }
}
