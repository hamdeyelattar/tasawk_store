import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/app/nav.dart';
import 'package:tasawk/src/core/app/upload_image/cubit/upload_image_cubit.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/language/lang_keys.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:tasawk/src/features/auth/presentation/screens/login_screen.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/auth_title_info.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/dark_lang_button.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/sign_widgets/sign_up_button.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/sign_widgets/sign_up_field.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/sign_widgets/user_avtar_image.dart';
import 'package:tasawk/src/injector.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 10.h,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<UploadImageCubit>(),
          ),
          BlocProvider(
            create: (context) => sl<AuthBloc>(),
          ),
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DarkLangButton(),
              20.ph,
              AuthTitleInfo(
                description: context.translate(LangKeys.signUpWelcome),
                title: context.translate(LangKeys.signUp),
              ),
              10.ph,
              const UserAvtarImage(),
              30.ph,
              const SignUpTextForm(),
              30.ph,
              const SignUpButton(),
              20.ph,
              GestureDetector(
                onTap: () {
                  NV.nextScreenCloseOthers(context, const LoginScreen());
                },
                child: TextApp(
                  text: context.translate(LangKeys.youHaveAccount),
                  theme: context.textStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.bold,
                    color: context.color.bluePinkLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
