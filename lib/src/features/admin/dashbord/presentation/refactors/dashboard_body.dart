import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/style/images/app_images.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/categories_number/categories_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/products_number/products_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/dashboard_blocs/users_number/users_number_bloc.dart';
import 'package:tasawk/src/features/admin/dashbord/presentation/widgets/dashboard_container.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 20.h,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          context
              .read<ProductsNumberBloc>()
              .add(const GetProductsNumberEvent());
          context
              .read<CategoriesNumberBloc>()
              .add(const GetCategoriesNumberEvent());
          context.read<UsersNumberBloc>().add(
                const GetUsersNumberEvent(),
              );
        },
        child: ListView(
          children: [
            BlocBuilder<ProductsNumberBloc, ProductsNumberState>(
              builder: (context, state) {
                return state.when(
                  loading: () {
                    return const DashBoardContiner(
                      tittle: 'Products',
                      number: '0',
                      image: AppImages.productsDrawer,
                      isLoading: true,
                    );
                  },
                  success: (productNumber) {
                    return DashBoardContiner(
                      tittle: 'Products',
                      number: productNumber,
                      image: AppImages.productsDrawer,
                      isLoading: false,
                    );
                  },
                  error: (errorMessage) {
                    return TextApp(
                      text: errorMessage,
                      theme: context.textStyle
                          .copyWith(color: Colors.red, fontSize: 16.sp),
                    );
                  },
                );
              },
            ),
            20.ph,
            BlocBuilder<CategoriesNumberBloc, CategoriesNumberState>(
              builder: (context, state) {
                return state.when(
                  loading: () {
                    return const DashBoardContiner(
                      tittle: 'Categories',
                      number: '0',
                      image: AppImages.categoriesDrawer,
                      isLoading: true,
                    );
                  },
                  success: (numbers) {
                    return DashBoardContiner(
                      tittle: 'Categories',
                      number: numbers,
                      image: AppImages.categoriesDrawer,
                      isLoading: false,
                    );
                  },
                  error: (errorMessage) {
                    return TextApp(
                      text: errorMessage,
                      theme: context.textStyle
                          .copyWith(color: Colors.red, fontSize: 16.sp),
                    );
                  },
                );
              },
            ),
            20.ph,
            BlocBuilder<UsersNumberBloc, UsersNumberState>(
              builder: (context, state) {
                return state.when(
                  loading: () {
                    return const DashBoardContiner(
                      tittle: 'Users',
                      number: '0',
                      image: AppImages.usersDrawer,
                      isLoading: true,
                    );
                  },
                  success: (numbers) {
                    return DashBoardContiner(
                      tittle: 'Users',
                      number: numbers,
                      image: AppImages.usersDrawer,
                      isLoading: false,
                    );
                  },
                  error: (errorMessage) {
                    return TextApp(
                      text: errorMessage,
                      theme: context.textStyle
                          .copyWith(color: Colors.red, fontSize: 16.sp),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
