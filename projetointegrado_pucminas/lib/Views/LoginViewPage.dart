import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import '../Utils/DefaultText.dart';

class LoginViewPage extends StatefulWidget {
  const LoginViewPage({super.key});

  @override
  State<LoginViewPage> createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  final navController = ScreenNavController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  navController.goBack();
                },
                child: SizedBox(
                    width: 50, // Adjust the width and height as needed.
                    height: 50,
                    child: Image.asset(
                      'assets/images/backicon.png', // Replace with your asset path.
                      fit: BoxFit.contain,
                    ))) // Adjust the fit as needed.
            ,
            Center(
              child: Column(
                children: [
                  InkWell(
                      child: SizedBox(
                          width: 250, // Adjust the width and height as needed.
                          height: 250,
                          child: Hero(
                            tag: 'loginLogo',
                            child: Image.asset(
                              'assets/images/login_logo.png', // Replace with your asset path.
                              fit: BoxFit.contain,
                            ),
                          ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        DefaultText(text: 'LOGIN FUNCIONÁRIOS', fontSize: 20),
                  ),
                  // ID FORM
                  Container(
                    width: 300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'ID',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              contentPadding: const EdgeInsets.all(16.0),
                            ),
                          ),
                        ),
                        // PASSWORD FORM
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'SENHA',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              contentPadding: const EdgeInsets.all(16.0),
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Implement your login logic here
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Adjust the radius as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultText(
                        text: 'LOGIN',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      )),
    );
  }
}
