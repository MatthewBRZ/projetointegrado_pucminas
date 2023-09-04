import 'package:flutter/material.dart';

class BakeryInfoWidget extends StatelessWidget {
  final String street, city, phone1, phone2;
  final double fontSize;
  final Color textColor;

  BakeryInfoWidget({
    this.street = 'Rua das padarias, 000',
    this.city = 'Belo Horizonte, MG',
    this.phone1 = '(00) 98765-4321',
    this.phone2 = '(00) 1234-5678',
    this.fontSize = 20.0,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          street,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
        Text(
          city,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          phone1,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
        Text(
          phone2,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
