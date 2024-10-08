import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawk/src/core/common/animations/animate_do.dart';
import 'package:tasawk/src/core/common/widgets/custom_text_field.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/language/lang_keys.dart';
import 'package:tasawk/src/core/utils/app_regex.dart';
import 'package:tasawk/src/features/auth/presentation/bloc/bloc/auth_bloc.dart';

class LoginTextFormField extends StatefulWidget {
  const LoginTextFormField({super.key});

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  bool isShowPassWord = true;
  late AuthBloc bloc;
  @override
  // ignore: always_declare_return_types, type_annotate_public_apis
  initState() {
    super.initState();
    bloc = context.read<AuthBloc>();
  }

  @override
  void dispose() {
    bloc.email.dispose();
    bloc.password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: bloc.formKey,
      child: Column(
        children: [
          CustomFadeInRight(
            duration: 300,
            child: CustomTextField(
              controller: bloc.email,
              hintText: context.translate(LangKeys.email),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (!AppRegex.isEmailValid(bloc.email.text)) {
                  return context.translate(LangKeys.validEmail);
                } else {
                  return null;
                }
              },
            ),
          ),
          20.ph,
          CustomFadeInRight(
            duration: 300,
            child: CustomTextField(
              controller: bloc.password,
              obscureText: isShowPassWord,
              hintText: context.translate(LangKeys.password),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return context.translate(LangKeys.validPasswrod);
                }
                return null;
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isShowPassWord = !isShowPassWord;
                  });
                },
                icon: Icon(
                  isShowPassWord ? Icons.visibility_off : Icons.visibility,
                  color: context.color.textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
