import 'package:flutter/material.dart';
import 'package:productosapp/providers/provider_form.dart';
import 'package:productosapp/ui/decoration.dart';
import 'package:productosapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBack(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              const SizedBox(height: 250),

              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: ( _) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text('Crear una cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50)
            ],
          ),
        ),
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return SizedBox(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInput(
                hintText: 'example.email@mail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);

                return regExp.hasMatch(value ?? '' ) ? null :'El correo no es valido';
              } , 
            ),

            const SizedBox(height: 30),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInput(
                hintText: '********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock
              ), 
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if(value!=null && value.length>=6) return null;

                return 'La contraseña debe ser mayor a 6 caracteres';
              } , 
            ),

            const SizedBox(height: 30),
            
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              disabledColor: Colors.grey,
              color: Colors.deepPurple[900],
              onPressed: loginForm.loading ? null : () async{
                FocusScope.of(context).unfocus();

                if(!loginForm.isValidForm()) return;

                loginForm.loading = true;

                await Future.delayed(const Duration(seconds: 1));

                loginForm.loading = false;

                Navigator.pushReplacementNamed(context, 'home');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(loginForm.loading ? 'Espere' : 'Ingresar', style: const TextStyle(color: Colors.white)),
              )
            )
          ],
        ),
      ),
    );
  }
}