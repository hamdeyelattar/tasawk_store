import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';

class HomeCustomerScreen extends StatelessWidget {
  const HomeCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: AppBar(
        backgroundColor: context.color.mainColor,
        title: const Text(
          'Home Customer',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: TextButton(
        onPressed: () {
          final res = FirebaseMessaging.instance.getToken();
          print(res);
        },
        child: const Text(
          'get token',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
