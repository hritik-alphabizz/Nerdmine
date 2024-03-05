import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nerdmine/utils/push_notification_service.dart';
import 'package:sizer/sizer.dart';

import 'screen/splash_screen.dart';
import 'utils/colors.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'a', // id
    'High Importance Notifications', // title
    showBadge: true,
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: MyColorName.colorTextThird, // navigation bar color
      statusBarColor: MyColorName.colorTextThird,
      statusBarIconBrightness: Brightness.light // status bar color
      ));

  // await Firebasep.initializeApp();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA9PpNpiNMkyI0nnxnjgboSHLji_2jqnqw",
            appId: "1:970701622319:ios:124e18c9d426b905030ada",
            messagingSenderId: "970701622319",
            projectId: "cp-mobile-app-a7646"));
  } else {
    await Firebase.initializeApp();
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/ic_app_logo',
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [NotificationChannelGroup(channelGroupName: 'Basic group', channelGroupKey: 'basic_channel_group')],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  await PushNotificationService().setupInteractedMessage();

  runApp(MyApp());

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    RegisterFirebaseNotification();

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Nerdmind',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.light(),
        themeMode: ThemeMode.light,
        initialRoute: "/",
        home: SplashScreen(),
        // home: TermsAndCondition(),
      );
    });
  }

  void RegisterFirebaseNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print("Message Received: ${message.data}");

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                playSound: true,
                icon: '@mipmap/ic_launcher_foreground',
              ),
            ));
      }
    });
  }

  void showNotification() {
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        )));
  }
}
