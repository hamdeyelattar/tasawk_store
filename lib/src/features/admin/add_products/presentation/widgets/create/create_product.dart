import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/app/upload_image/cubit/upload_image_cubit.dart';
import 'package:tasawk/src/core/common/bottom_sheet/custom_bottom_sheet.dart';
import 'package:tasawk/src/core/common/widgets/custom_button.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/core/style/fonts/font_family_helper.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/get_all_admin_category_bloc/bloc/get_all_admin_categories_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/crate_product/bloc/create_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/bloc/get_all_admin_product/bloc/get_all_admin_product_bloc.dart';
import 'package:tasawk/src/features/admin/add_products/presentation/widgets/create/create_product_bottom_sheet.dart';
import 'package:tasawk/src/injector.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextApp(
          text: 'Get All Products',
          theme: context.textStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeightHelper.medium,
            fontFamily: FontFamilyHelper.poppinsEnglish,
          ),
        ),
        CustomButton(
          onPressed: () {
            CustomBottomSheet.showModalBottomSheetContainer(
              context: context,
              widget: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<CreateProductBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => sl<UploadImageCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => sl<GetAllAdminCategoriesBloc>()
                      ..add(
                        const GetAllAdminCategoriesEvent.fetchAdminCategories(
                          isNotLoading: false,
                        ),
                      ),
                  ),
                ],
                child: const CreateProductBottomSheet(),
              ),
              whenComplete: () {
                context.read<GetAllAdminProductBloc>().add(
                      const GetAllAdminProductEvent.getAllProducts(
                        isNotLoading: false,
                      ),
                    );
              },
            );
          },
          backgroundColor: ColorsDark.blueDark,
          lastRadius: 10,
          threeRadius: 10,
          text: 'Add',
          width: 90.w,
          height: 35.h,
        ),
      ],
    );
  }
}
