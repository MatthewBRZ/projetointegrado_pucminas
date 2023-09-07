import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Controllers/InputControllers.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Controllers/TableController.dart';
import 'package:projetointegrado_pucminas/Utils/DefaultText.dart';
import 'package:projetointegrado_pucminas/Utils/FormValidator.dart';
import 'package:projetointegrado_pucminas/Utils/InputFormBuilder.dart';
import 'package:projetointegrado_pucminas/Views/MenuViewPage.dart';

class IdentificationViewPage extends StatefulWidget {
  const IdentificationViewPage({super.key});

  @override
  State<IdentificationViewPage> createState() => _IdentificationViewPageState();
}

class _IdentificationViewPageState extends State<IdentificationViewPage> {
  final navController = ScreenNavController();
  final clientInput = Get.find<InputControllers>().clientIdController;
  final qrCodeGet = Get.find<TableController>();
  late InputFormBuilder inputFormBuilder;
  final formValidator = FormValidator();

  @override
  void initState() {
    super.initState();
    // Initializing Forms
    inputFormBuilder = InputFormBuilder(
      controller: clientInput,
      hintText: 'Digite o seu nome',
      validatorCallback: (value) => formValidator.clientValidator(value),
    );
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
                  dispose();
                },
                child: SizedBox(
                    width: 50, // Adjust the width and height as needed.
                    height: 50,
                    child: Image.asset(
                      'assets/images/backicon.png', // Replace with your asset path.
                      fit: BoxFit.contain,
                    ))) // Adjust the fit as needed.
            ,
            Align(
              alignment: Alignment.topRight,
              child: DefaultText(
                text: '${qrCodeGet.tableType}-${qrCodeGet.tableNumber}',
                fontSize: 20,
              ),
            ),
            Center(
              child: Column(
                children: [
                  InkWell(
                      child: SizedBox(
                          width: 250, // Adjust the width and height as needed.
                          height: 250,
                          child: Hero(
                            tag: 'bakeryLogo',
                            child: Image.asset(
                              'assets/images/bakery_logo.png', // Replace with your asset path.
                              fit: BoxFit.contain,
                            ),
                          ))),
                  DefaultText(text: 'QUAL O SEU NOME?', fontSize: 20),
                  // ID FORM
                  inputFormBuilder,
                  // Button to access the Menu
                  ElevatedButton(
                    onPressed: () {
                      // Validate the inputForm before goes to another screen
                      if (inputFormBuilder.form.currentState!.validate()) {
                        //navController.navigateToScreen(const MenuViewPage());
                        navController.navigateToScreen(const MenuViewPage());
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
                        text: 'ACESSAR CARDÁPIO',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
