import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pitaya_web/firebase_options.dart';
import 'package:pitaya_web/screens/dash/dashboard.dart';
import 'package:pitaya_web/screens/dashboard.dart';
import 'package:pitaya_web/screens/auth/login.dart';
import 'package:pitaya_web/services/auth.dart';
import 'package:pitaya_web/services/route.dart';
import 'package:provider/provider.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  /*why stateful? = for updating the UI in response to the users input or change in data. In our case
                                      thats for selecting a category and uploading a photo, para makita dayon sng user ang ila gn select*/
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        debugShowCheckedModeBanner: false,
        title: 'Pitaya Clinic',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        ),
        home: const MainAuthPage(),
      ),
    );
  }
}

class MainAuthPage extends StatefulWidget {
  const MainAuthPage({
    Key? key,
  }) : super(key: key);

  @override
  _MainAuthPageState createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseuser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: context.read<AuthService>().authStateChanges,
        builder: (context, snapshot) {
          //return JoinToday();
          if (firebaseuser == null) {
            return const LoginScreen();
          } else {
            return const MainDashboard();
          }
        },
      ),
    );
  }
}
