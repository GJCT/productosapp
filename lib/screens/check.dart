import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productosapp/services/auth.dart';

class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    return Scaffold(
      body: Center(
         child: FutureBuilder(
          future: authServices.readToken(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return const Text('Espere');
            }
            if(snapshot.data == ''){
              Future.microtask(() {
                Navigator.pushReplacementNamed(context, 'login');
              });              
            }else {
              Future.microtask(() {
                Navigator.pushReplacementNamed(context, 'home');
              }); 
            }

            return Container();
          },
        ),
      ),
    );
  }
}