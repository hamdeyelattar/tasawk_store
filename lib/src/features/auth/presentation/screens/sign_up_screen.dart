import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/features/auth/presentation/refactors/auth_custom_painter.dart';
import 'package:tasawk/src/features/auth/presentation/refactors/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomPaint(
        size: Size(
          context.width,
          160.h,
        ),
        painter: AuthCustomPainter(
          gradient: LinearGradient(
            colors: [
              context.color.bluePinkLight!,
              context.color.bluePinkLight!,
              context.color.bluePinkLight!,
              context.color.bluePinkDark!,
            ],
          ),
        ),
      ),
      body: const SafeArea(bottom: false, child: SignUpBody()),
    );
  }
}
