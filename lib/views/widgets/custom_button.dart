import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;
  final Color textColor;
  final bool isEnabled;
  final bool isBorderEnabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.green,
    this.textColor = Colors.white,
    this.isEnabled = true,
    this.isBorderEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? () => onTap() : null,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: color,
        shape: isEnabled
            ? RoundedRectangleBorder(
                side: BorderSide(
                    color: isBorderEnabled ? Colors.green : Colors.transparent),
                borderRadius: const BorderRadius.all(
                  Radius.circular(3),
                ),
              )
            : null,
        minimumSize: const Size(
          double.infinity,
          (40),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
