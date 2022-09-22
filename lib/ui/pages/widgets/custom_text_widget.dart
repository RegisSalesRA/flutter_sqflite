import 'package:flutter/material.dart';

class CustomTextFormWidget extends StatelessWidget {
  final IconData icon;
  final String? hintText;
  // final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  const CustomTextFormWidget({
    Key? key,
    required this.icon,
    this.validator,
    this.controller,
    this.hintText,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // inputFormatters: inputFormatters,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
