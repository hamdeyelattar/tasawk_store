import 'package:flutter/material.dart';
import 'package:tasawk/src/core/common/widgets/admin_app_bar.dart';
import 'package:tasawk/src/core/style/colors/colors_dark.dart';

class AddNotificationsScreen extends StatelessWidget {
  const AddNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsDark.mainColor,
      appBar: AdminAppBar(
        isMain: true,
        backgroundColor: ColorsDark.mainColor,
        title: 'Notifications',
      ),
      body: Center(
        child: Text(
          'Add Notifications',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
