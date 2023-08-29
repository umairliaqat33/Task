import 'package:flutter/material.dart';
import 'package:task/models/employee/emp_model.dart';
import 'package:task/views/widgets/custom_emp_row_widget.dart';

class EmpProfileScreen extends StatelessWidget {
  final EmpModel empModel;
  const EmpProfileScreen({
    super.key,
    required this.empModel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      scrollable: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 500,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Image.network(
              empModel.imageLing,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 8),
          CustomEmpRowWidget(
            rowName: 'Name',
            rowData: empModel.name,
          ),
          CustomEmpRowWidget(
            rowName: 'Phone Number',
            rowData: empModel.phone,
          ),
          CustomEmpRowWidget(
            rowName: 'Email',
            rowData: empModel.email,
          ),
          CustomEmpRowWidget(
            rowName: 'Department',
            rowData: empModel.department,
          ),
          CustomEmpRowWidget(
            rowName: 'Designation',
            rowData: empModel.designation,
          ),
        ],
      ),
    );
  }
}
