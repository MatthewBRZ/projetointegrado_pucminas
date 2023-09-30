import 'package:flutter/material.dart';

// Custom Generic InputForm Builder
class InputFormBuilder extends StatelessWidget {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final String? Function(String?)? validatorCallback;
  final TextEditingController controller;
  final String hintText;

  InputFormBuilder({
    required this.hintText,
    required this.validatorCallback,
    required this.controller,
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
            controller: controller,
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
