import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Utils/FormValidator.dart';

class InputFormBuilder extends StatelessWidget {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final String? Function(String?)? validatorCallback;
  final hintText;

  InputFormBuilder({
    required this.hintText,
    required this.validatorCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: form,
          child: TextFormField(
            validator: validatorCallback,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              contentPadding: const EdgeInsets.all(16.0),
            ),
          ),
        ),
      ),
    );
  }
}
