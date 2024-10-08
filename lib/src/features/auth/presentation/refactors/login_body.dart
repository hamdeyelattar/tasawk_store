import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/app/nav.dart';
import 'package:tasawk/src/core/common/widgets/text_app.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/language/lang_keys.dart';
import 'package:tasawk/src/core/style/fonts/font_weight_helper.dart';
import 'package:tasawk/src/features/admin/home_admin/presentation/screen/home_admin_screen.dart';
import 'package:tasawk/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:tasawk/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/auth_title_info.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/dark_lang_button.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/login_widgets/login_button.dart';
import 'package:tasawk/src/features/auth/presentation/widgets/login_widgets/login_form_field.dart';
import 'package:tasawk/src/injector.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 10.h,
      ),
      child: BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DarkLangButton(),
              20.ph,
              AuthTitleInfo(
                description: context.translate(LangKeys.welcome),
                title: context.translate(LangKeys.login),
              ),
              50.ph,
              const LoginTextFormField(),
              30.ph,
              const LoginButton(),
              20.ph,
              GestureDetector(
                onTap: () {
                  NV.nextScreenCloseOthers(context, const SignUpScreen());
                },
                child: TextApp(
                  text: context.translate(LangKeys.createAccount),
                  theme: context.textStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeightHelper.bold,
                    color: context.color.bluePinkLight,
                  ),
                ),
              ),
              InkWell(
                child: Text('dashboard'),
                onTap: () {
                  NV.nextScreen(context, HomeAdminScreen());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
