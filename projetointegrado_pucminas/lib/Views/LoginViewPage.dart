import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Controllers/InputControllers.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Utils/InputFormBuilder.dart';
import 'package:projetointegrado_pucminas/Views/OptionsViewPage.dart';
import '../Utils/DefaultText.dart';
import '../Utils/FormValidator.dart';

class LoginViewPage extends StatefulWidget {
  const LoginViewPage({super.key});

  @override
  State<LoginViewPage> createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  final navController = ScreenNavController();
  final userInput = InputControllers().userNameController;
  final passInput = InputControllers().passwordController;
  late InputFormBuilder idFormBuilder;
  late InputFormBuilder passFormBuilder;
  final formValidator = FormValidator();

  @override
  void initState() {
    super.initState();
    //Initializing Forms
    idFormBuilder = InputFormBuilder(
        controller: userInput,
        hintText: 'ID',
        validatorCallback: (value) => formValidator.userValidator(value));
    // PASS FORM
    passFormBuilder = InputFormBuilder(
        controller: passInput,
        hintText: 'SENHA',
        validatorCallback: (value) => formValidator.passValidator(value));
  }

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
                  idFormBuilder,
                  // PASS FORM
                  passFormBuilder,
                  // Spacing
                  const SizedBox(height: 15),
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Validate the inputForm before goes to another screen
                      if (idFormBuilder.form.currentState!.validate() &&
                          passFormBuilder.form.currentState!.validate()) {
                        navController.navigateToScreen(const OptionsViewPage());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
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
