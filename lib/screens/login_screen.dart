//import 'dart:convert' as boton;

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/DashboardScreen.dart';
import 'package:lottie/lottie.dart' show Lottie;

class LoginScreen extends StatefulWidget {
  const LoginScreen ({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController conUser = TextEditingController();
  TextEditingController conPass = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(

          image: DecorationImage(
            
            image: AssetImage('assets/fondo.jpg'))
        ),

        child: Stack(

          alignment: Alignment.center,
          children: [
            Positioned(
              
              top: 100,
              child: Image.asset('assets/logo.png', width: 400,)
            ),

            Positioned(

              bottom: 100,
              child: Container(

                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(

                  color: Color(0xCCBDBDBD),   
                  borderRadius: BorderRadius.circular(10)
                ),

                width: 400,
                //height: 105,
                child: ListView(

                  shrinkWrap: true,
                  children: [
                    TextFormField(

                      controller: conUser,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(

                        label: Text("Nombre de Usuario"),
                        border: OutlineInputBorder()
                      ),
                    ),

                    const SizedBox(height: 10),
                    TextFormField(

                      controller: conPass,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration:  const InputDecoration(

                        hintText: 'Contraseña',
                        border: OutlineInputBorder()
                      )
                    )
                  ]
                ),
              )
            ),
            InkWell(onTap: () { 
              isLoading = true;
              setState((){});},
              child: InkWell(
                onTap: (){
                  isLoading = true;
                  setState((){});

                  Future.delayed(Duration(seconds: 4)).then((value) {
                    Navigator.pushNamed(context, '/dash');
                  },);

                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardScreen()
                    )
                  );*/
                },
                child: Lottie.asset('assets/boton.json', width: 220)
              
              ),
            ),
            Positioned(
              top: 250,
              child: isLoading
              ? Lottie.asset('assets/loading.json', height: 150)
              : Container()
            )  
          ],
        )
      ),
    );
  }
}