import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tasawk/src/core/app/env_variables.dart';
import 'package:tasawk/src/core/common/toast/show_toast.dart';
import 'package:tasawk/src/core/extensions/context_extension.dart';
import 'package:tasawk/src/core/language/lang_keys.dart';

class FirebaseCloudMessaging {
  factory FirebaseCloudMessaging() => _instance;
  FirebaseCloudMessaging._();
  static final FirebaseCloudMessaging _instance = FirebaseCloudMessaging._();
  final _firebaseMessaging = FirebaseMessaging.instance;
  static const String subscripkey = 'taswak_store';
  ValueNotifier<bool> isNotificationSubscribe = ValueNotifier(true);
  bool isPermissionNotification = false;
  Future<void> init() async {
    //permission
    await _permissionsNotification();
  }

  /// permision notification
  Future<void> _permissionsNotification() async {
    final settings = await _firebaseMessaging.requestPermission(badge: false);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      /// subscribe to notifications topic
      isPermissionNotification = true;
      await _subscribeNotification();
      debugPrint('🔔🔔 User accepted the notification permission');
    } else {
      isPermissionNotification = false;
      isNotificationSubscribe.value = false;
      debugPrint('🔕🔕 User not accepted the notification permission');
    }
  }

  /// controller for the notification if user subscribe or unsubscribed
  /// or accpeted the permission or not

  Future<void> controllerForUserSubscribe(BuildContext context) async {
    if (isPermissionNotification == false) {
      await _permissionsNotification();
    } else {
      if (isNotificationSubscribe.value == false) {
        await _subscribeNotification();
        if (!context.mounted) return;
        ShowToast.showToastSuccessTop(
          message: context.translate(LangKeys.subscribedToNotifications),
          seconds: 2,
        );
      } else {
        await _unSubscribeNotification();
        if (!context.mounted) return;
        ShowToast.showToastSuccessTop(
          message: context.translate(LangKeys.unsubscribedToNotifications),
          seconds: 2,
        );
      }
    }
  }

  Future<void> _subscribeNotification() async {
    isNotificationSubscribe.value = true;
    await FirebaseMessaging.instance.subscribeToTopic(subscripkey);
    debugPrint('====🔔 Notification Subscribed 🔔=====');
  }

  /// unsubscribe notification

  Future<void> _unSubscribeNotification() async {
    isNotificationSubscribe.value = false;
    await FirebaseMessaging.instance.unsubscribeFromTopic(subscripkey);
    debugPrint('====🔕 Notification Unsubscribed 🔕=====');
  }

  // send notification with api
  Future<void> sendTopicNotification({
    required String title,
    required String body,
    required int productId,
  }) async {
    try {
      final response = await Dio().post<dynamic>(
        EnvVariable.instance.notificationBaseUrl,
        options: Options(
          validateStatus: (status) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'key=${EnvVariable.instance.firebaseKey}',
          },
        ),
        data: {
          'to': '/topics/$subscripkey',
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {'productId': productId},
        },
      );
    } catch (e) {
      debugPrint('Notification Error:=> $e');
    }
  }
}
