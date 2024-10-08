import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/common/toast/show_toast.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/delete_category/bloc/delete_category_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/get_all_admin_category_bloc/bloc/get_all_admin_categories_bloc.dart';

class DeleteCategoryWidget extends StatelessWidget {
  const DeleteCategoryWidget({
    required this.categoryId,
    super.key,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteCategoryBloc, DeleteCategoryState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            context.read<GetAllAdminCategoriesBloc>().add(
                  const GetAllAdminCategoriesEvent.fetchAdminCategories(
                    isNotLoading: false,
                  ),
                );
            ShowToast.showToastSuccessTop(
              message: 'Your category has been deleted',
            );
          },
          error: (errorMessage) {
            ShowToast.showToastErrorTop(
              message: errorMessage,
            );
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: (id) {
            if (id == categoryId) {
              return SizedBox(
                height: 15.h,
                width: 15.w,
                child: const CircularProgressIndicator(
                  color: ColorsDark.white,
                ),
              );
            } else {
              return const Icon(
                Icons.delete,
                color: Colors.red,
                size: 25,
              );
            }
          },
          orElse: () {
            return InkWell(
              onTap: () {
                context.read<DeleteCategoryBloc>().add(
                      DeleteCategoryEvent.deleteCategory(
                        categoryId: categoryId,
                      ),
                    );
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 25,
              ),
            );
          },
        );
      },
    );
  }
}
