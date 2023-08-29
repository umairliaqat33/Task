import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String? Function(dynamic) validator;
  final IconData icon;
  final bool obsecureText;

  const TextFieldWidget({
    super.key,
    required this.textController,
    required this.hintText,
    required this.validator,
    required this.icon,
    required this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      validator: validator,
      textAlign: TextAlign.start,
      obscureText: obsecureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        hintText: hintText,
        icon: Icon(icon),
      ),
    );
  }
}
