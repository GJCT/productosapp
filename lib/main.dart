import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productosapp/services/services.dart';
import 'package:productosapp/screens/screens.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _) => AuthServices()),
        ChangeNotifierProvider(create: ( _) => ProductServices()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: {
        'home': ( _) => const HomeScreen(),
        'product': ( _) => const ProductScreen(),

        'login': ( _) => const LoginScreen(),
        'register': ( _) => const RegisterScreen(),

        'check': ( _) => const CheckAuthScreen(),
      },
      scaffoldMessengerKey: NotificationsService.messanger,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[400],
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple[900]
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple[900]
        )
      ),
    );
  }
}