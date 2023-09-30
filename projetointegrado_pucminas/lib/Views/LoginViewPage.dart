import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Controllers/InputControllers.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Utils/InputFormBuilder.dart';
import 'package:projetointegrado_pucminas/Views/OptionsViewPage.dart';
import '../Models/Auth.dart';
import '../Utils/DefaultText.dart';
import '../Utils/FormValidator.dart';

// Attendant Login Page
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
  final auth = Auth();

  @override
  void initState() {
    super.initState();
    //Initializing Forms
    idFormBuilder = InputFormBuilder(
        controller: userInput,
        hintText: 'ID',
        validatorCallback: (value) => formValidator.userValidator(value));
    // Password Form
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
                    width: 50,
                    height: 50,
                    child: Image.asset(
                      'assets/images/backicon.png',
                      fit: BoxFit.contain,
                    ))),
            Center(
              child: Column(
                children: [
                  InkWell(
                      child: SizedBox(
                          width: 250,
                          height: 250,
                          child: Hero(
                            tag: 'loginLogo',
                            child: Image.asset(
                              'assets/images/login_logo.png',
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
                    onPressed: () async {
                      // Validate the inputForm before goes to another screen
                      if (idFormBuilder.form.currentState!.validate() &&
                          passFormBuilder.form.currentState!.validate()) {
                        // Check for valid authentiation and go to another screen
                        if (await auth.authenticate(
                            idFormBuilder.controller.text,
                            passFormBuilder.controller.text)) {
                          navController
                              .navigateToScreen(const OptionsViewPage());
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Color(0xFFC68958),
                            content: Text(
                              'Usuário e/ou senha incorretos.',
                            ),
                            duration: Duration(seconds: 3),
                          ));
                        }
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
