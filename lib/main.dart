import 'package:flutter/material.dart';
import 'package:productosapp/screens/screens.dart';
import 'package:productosapp/services/product.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _) => ProductServices())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'home',
      routes: {
        'login': ( _) => const LoginScreen(),
        'home': ( _) => const HomeScreen(),
        'product': ( _) => const ProductScreen()
      },
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