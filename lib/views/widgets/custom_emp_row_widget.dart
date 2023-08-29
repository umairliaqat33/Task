import 'package:flutter/material.dart';

class CustomEmpRowWidget extends StatelessWidget {
  final String rowName;
  final String rowData;
  const CustomEmpRowWidget({
    super.key,
    required this.rowName,
    required this.rowData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          rowName,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: Colors.grey.withOpacity(1),
          ),
        ),
        Text(
          rowData,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
