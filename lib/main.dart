import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:grocery_delivery_app/provider/auth_provider.dart';
import 'package:grocery_delivery_app/provider/order_provider.dart';
import 'package:grocery_delivery_app/screens/SplashScreen.dart';
import 'package:grocery_delivery_app/screens/home_screen.dart';
import 'package:grocery_delivery_app/screens/login_screen.dart';
import 'package:grocery_delivery_app/screens/register_screen.dart';
import 'package:grocery_delivery_app/screens/resetPassword_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => auth_provider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Grocery Store Delivery App",
      builder: EasyLoading.init(),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ResetPassword.id: (context) => ResetPassword(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
