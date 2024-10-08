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
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/create_category/bloc/create_category_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/get_all_admin_category_bloc/bloc/get_all_admin_categories_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/widgets/create/create_category_botom_widget.dart';
import 'package:tasawk/src/injector.dart';

class CreateCategory extends StatelessWidget {
  const CreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextApp(
          text: 'Get All Categories',
          theme: context.textStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeightHelper.medium,
            fontFamily: FontFamilyHelper.poppinsEnglish,
            color: Colors.white,
          ),
        ),
        CustomButton(
          onPressed: () {
            CustomBottomSheet.showModalBottomSheetContainer(
              context: context,
              widget: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => sl<CreateCategoryBloc>(),
                  ),
                  BlocProvider(
                    create: (context) => sl<UploadImageCubit>(),
                  ),
                ],
                child: const CreateCategoryBottomWidget(),
              ),
              whenComplete: () {
                context.read<GetAllAdminCategoriesBloc>().add(
                      const GetAllAdminCategoriesEvent.fetchAdminCategories(
                        isNotLoading: false,
                      ),
                    );
              },
            );
          },
          text: 'Add',
          width: 90.w,
          height: 35.h,
          lastRadius: 10,
          threeRadius: 10,
          backgroundColor: ColorsDark.blueDark,
        ),
      ],
    );
  }
}
