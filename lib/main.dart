// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'dart:async';
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'message.dart';
import 'message_list.dart';
import 'permissions.dart';
import 'token_monitor.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MessagingExampleApp());
}

/// Entry point for the example application.
class MessagingExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging Example App',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => Application(),
        '/message': (context) => MessageView(),
      },
    );
  }
}

// Crude counter to make messages unique
int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

/// Renders the example application.
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  String _token;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.pushNamed(context, '/message',
            arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));
    });
  }

  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/app-dev-c912f/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Autorization':
              'Bearer AAAACF7wA-g:APA91bFu52tXr-r5t4lt6Y07g5RNxlTHzHPXCR9if0zF4BEZ1WLn6xuc_-0PkFwPrM0mjA-tWp5DbV34UKLI5h5f_1YfdZAa0UBFwXOUnEPOKIIkErhAdgQes3DGokgRb9Fj4QEROvg_'
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
      print(response);
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
        }
        break;
      case 'unsubscribe':
        {
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String token = await FirebaseMessaging.instance.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
                'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
          }
        }
        break;
      default:
        break;
    }
  }

  Future<void> sendFcmWithTokens(
      List tokens, String title, String message, String route) async {
    HttpsCallable callFcm = FirebaseFunctions.instance.httpsCallable('sendFcm');

    String alarmId = "alarmId";

    var payload = <String, dynamic>{
      "tokens": tokens,
      "title": title,
      "message": message,
      "alarmId": alarmId,
      "route": route,
    };
    print("send FCM with Tokens");
    print(payload);
    print(payload["title"]);
    print(payload["message"]);

    try {
      await callFcm.call(payload);
    } catch(exception) {
      print(exception.toString());
    }
  }

  Future<void> fcmTest() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sendFcm');

    final results = await callable();
    print(results.data);
  }

  final HttpsCallable sendFCM = FirebaseFunctions.instance
      .httpsCallable('sendFCM'); // 호출할 Cloud Functions 의 함수명
  // ..timeout = const Duration(seconds: 30);

  void sendFcmWithData(// {List<String> tokenList,
      //   String team,
      //   String name,
      //   String position,
      //   String collection,
      //   String alarmId}
      ) async {
    await sendFCM.call(
      // final HttpsCallableResult result = await sendFCM.call(
      <String, dynamic>{
        // "token": tokenList,
        // "team": team,
        // "name": name,
        // "position": position,
        // "collection": collection,
        // "alarmId": alarmId,

        // "token": "APA91bFD7je0qEB_Cxmgc8vAUtQYjAitwvT9R8bAH8hTxKXDpQDnqpXV35j2qcDRioxPqOPbRr9iy-AWS-HPUtuUFCtRJ479fijGR-6CK_-V3mm8X9jL2XQoE2DLsnmLV9l_FkW3xC25",
        // "team": "team",
        // "name": "name",
        // "position": "position",
        // "collection": "test",
        // "alarmId": "34563456",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Messaging'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: onActionSelected,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'subscribe',
                  child: Text('Subscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'unsubscribe',
                  child: Text('Unsubscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'get_apns_token',
                  child: Text('Get APNs token (Apple only)'),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: sendPushMessage,
          backgroundColor: Colors.white,
          child: const Icon(Icons.send),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          MetaCard('Permissions', Permissions()),
          MetaCard('FCM Token', TokenMonitor((token) {
            _token = token;
            return token == null
                ? const CircularProgressIndicator()
                : Text(token, style: const TextStyle(fontSize: 12));
          })),
          MetaCard('Message Stream', MessageList()),
          ElevatedButton(
            onPressed: () => {
              sendFcmWithTokens(
                  ["dWpBjnBURk6VG1_8u2CKgr:APA91bFD7je0qEB_Cxmgc8vAUtQYjAitwvT9R8bAH8hTxKXDpQDnqpXV35j2qcDRioxPqOPbRr9iy-AWS-HPUtuUFCtRJ479fijGR-6CK_-V3mm8X9jL2XQoE2DLsnmLV9l_FkW3xC25", // ['token_1', 'token_2', ...]
                    "fpSG1tZIjUiCj-4Z-E6dhA:APA91bGotWmG8iTJVSo4GOMZBO4qIJ-JFZw8--a5wmAam8g5r3YSG8HcdkUI_iEHo17MJnwLt0skIdfAtH9USlJggWDJbALlexyakeQ9n1ecG6Dep8zjrs9zxS8dg7QVLbDjAdrclsPJ"],
                  "title",
                  "contents",
                  "/")
            },
          )
        ]),
      ),
    );
  }
}

/// UI Widget for displaying metadata.
class MetaCard extends StatelessWidget {
  final String _title;
  final Widget _children;

  // ignore: public_member_api_docs
  MetaCard(this._title, this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child:
                          Text(_title, style: const TextStyle(fontSize: 18))),
                  _children,
                ]))));
  }
}
