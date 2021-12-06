import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_example/red_page.dart';
import 'package:notification_example/services/local_notification.dart';

import 'green_page.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("backgroundMessageHandler");
  print(message.data.toString());
  print(message.notification!.title.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        "red": (_) => const RedPage(),
        "green": (_) => const GreenPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);

    ///gives you message/notification on which users taps
    /// and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["routePage"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    //will work only if the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }
      LocalNotificationService.display(message);
    });

    ///when user tap on the notification and the app is opened in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        final routeFromMessage = message.data["routePage"];
        print(routeFromMessage);
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Message will appear here", style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
