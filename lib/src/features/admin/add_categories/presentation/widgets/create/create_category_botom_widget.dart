import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/app/upload_image/cubit/upload_image_cubit.dart';
import 'package:tasawk/src/core/common/toast/show_toast.dart';
import 'package:tasawk/src/core/common/widgets/custom_button.dart';
import 'package:tasawk/src/core/common/widgets/custom_text_field.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/language/lang_keys.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';
import 'package:tasawk/src/core/style/fonts/font_family_helper.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/admin/add_categories/data/models/create_category_request_body.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/blocs/create_category/bloc/create_category_bloc.dart';
import 'package:tasawk/src/features/admin/add_categories/presentation/widgets/create/category_upload_image.dart';

class CreateCategoryBottomWidget extends StatefulWidget {
  const CreateCategoryBottomWidget({super.key});

  @override
  State<CreateCategoryBottomWidget> createState() =>
      _CreateCategoryBottomWidgetState();
}

class _CreateCategoryBottomWidgetState
    extends State<CreateCategoryBottomWidget> {
  final formKey = GlobalKey<FormState>();
  final nameCategoryController = TextEditingController();
  @override
  void dispose() {
    nameCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TextApp(
                text: 'Create Category',
                theme: context.textStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeightHelper.bold,
                  fontFamily: FontFamilyHelper.poppinsEnglish,
                ),
              ),
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextApp(
                  text: 'Add a photo',
                  theme: context.textStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.medium,
                    fontFamily: FontFamilyHelper.poppinsEnglish,
                  ),
                ),
                BlocBuilder<UploadImageCubit, UploadImageState>(
                  builder: (context, state) {
                    if (context.read<UploadImageCubit>().getImageUrl.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return CustomButton(
                      onPressed: () {
                        context.read<UploadImageCubit>().removeImage();
                      },
                      backgroundColor: Colors.red,
                      lastRadius: 10,
                      threeRadius: 10,
                      text: 'Remove',
                      width: 120.w,
                      height: 35.h,
                    );
                  },
                ),
              ],
            ),
            20.ph,
            const CategoryUploadImage(),
            20.ph,
            TextApp(
              text: 'Enter the Category Name',
              theme: context.textStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeightHelper.medium,
                fontFamily: FontFamilyHelper.poppinsEnglish,
              ),
            ),
            20.ph,
            CustomTextField(
              controller: nameCategoryController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Category Name',
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 2) {
                  return 'Please Selected Your Category Name';
                }
                return null;
              },
            ),
            20.ph,
            BlocConsumer<CreateCategoryBloc, CreateCategoryState>(
              listener: (context, state) {
                state.whenOrNull(
                  success: () {
                    context.pop();
                    ShowToast.showToastSuccessTop(
                      message: '${nameCategoryController.text} Created Success',
                      seconds: 2,
                    );
                  },
                  error: (error) {
                    ShowToast.showToastErrorTop(
                      message: error,
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () {
                    return Container(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: ColorsDark.blueDark,
                        ),
                      ),
                    );
                  },
                  orElse: () {
                    return CustomButton(
                      onPressed: () {
                        _validCreateCategory(context);
                      },
                      backgroundColor: ColorsDark.white,
                      lastRadius: 20,
                      threeRadius: 20,
                      textColor: ColorsDark.blueDark,
                      text: 'Create a new category',
                      width: MediaQuery.of(context).size.width,
                      height: 50.h,
                    );
                  },
                );
              },
            ),
            20.ph,
          ],
        ),
      ),
    );
  }

  void _validCreateCategory(BuildContext context) {
    if (formKey.currentState!.validate() ||
        context.read<UploadImageCubit>().getImageUrl.isEmpty) {
      if (context.read<UploadImageCubit>().getImageUrl.isEmpty) {
        ShowToast.showToastErrorTop(
          message: context.translate(LangKeys.validPickImage),
        );
      } else {
        // send category
        context.read<CreateCategoryBloc>().add(
              CreateCategoryEvent.createCategory(
                body: CreateCategoryRequestBody(
                  image: context.read<UploadImageCubit>().getImageUrl,
                  name: nameCategoryController.text.trim(),
                ),
              ),
            );
      }
    }
  }
}
