// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/models/employee/emp_model.dart';
import 'package:task/repositories/firestore_repository.dart';
import 'package:task/services/media_services.dart';
import 'package:task/utils/exceptions.dart';
import 'package:task/utils/validators.dart';
import 'package:task/views/home/home_screen.dart';
import 'package:task/views/widgets/custom_button.dart';
import 'package:task/views/widgets/image_picker_widget.dart';
import 'package:task/views/widgets/text_field.dart';

class EmployeeInformationScreen extends StatefulWidget {
  const EmployeeInformationScreen({super.key});

  @override
  State<EmployeeInformationScreen> createState() =>
      _EmployeeInformationScreenState();
}

class _EmployeeInformationScreenState extends State<EmployeeInformationScreen> {
  final _nameController = TextEditingController();
  final _desgController = TextEditingController();
  final _deptController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? _profilePlatformFile;
  String? _imageLink;
  bool _showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Enter Employee info",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                  ),
                  child: Text(
                    "Please enter employee information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextFieldWidget(
                  textController: _nameController,
                  hintText: 'John Doe',
                  validator: (value) => Validators.nameValidator(value),
                  icon: Icons.person,
                  obsecureText: false,
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                  textController: _emailController,
                  hintText: 'johndoe@xyz.com',
                  validator: (value) => Validators.emailValidator(value),
                  icon: Icons.email,
                  obsecureText: false,
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                  textController: _phoneController,
                  hintText: '+9212345678901',
                  validator: (value) => Validators.phoneValidator(value),
                  icon: Icons.phone,
                  obsecureText: false,
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                  textController: _deptController,
                  hintText: 'Computer Science',
                  validator: (value) => Validators.deptValidator(value),
                  icon: Icons.reduce_capacity_rounded,
                  obsecureText: false,
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                  textController: _desgController,
                  hintText: 'Manager',
                  validator: (value) => Validators.desigValidator(value),
                  icon: Icons.person,
                  obsecureText: false,
                ),
                const SizedBox(height: 16),
                ImagePickerBigWidget(
                  heading: 'Profile Photo',
                  description:
                      'add a close-up image of yourself max size is 2 MB',
                  onPressed: () async => _selectProfileImage(),
                  platformFile: _profilePlatformFile,
                  imgUrl: _imageLink,
                ),
                const SizedBox(height: 8),
                _showSpinner
                    ? const CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : CustomButton(
                        text: "Save",
                        onTap: () => uploadInformation(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectProfileImage() async {
    try {
      _profilePlatformFile = await MediaService.selectFile();
      if (_profilePlatformFile != null) {
        log("Big Image Clicked");
        log(_profilePlatformFile!.name);
      } else {
        log("no file selected");
        return;
      }
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> uploadInformation() async {
    setState(() {
      _showSpinner = true;
    });
    FirestoreRepository firestoreRespository = FirestoreRepository();
    if (_formKey.currentState!.validate()) {
      try {
        String? profilePicture = await MediaService.uploadFile(
          _profilePlatformFile,
          _nameController.text,
        );

        firestoreRespository.uploadEmpInformation(
          EmpModel(
            name: _nameController.text,
            department: _deptController.text,
            designation: _desgController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            imageLing: profilePicture!,
          ),
        );
        Fluttertoast.showToast(msg: 'Data uploading complete');

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false,
        );
      } on UnknownException catch (e) {
        Fluttertoast.showToast(msg: e.message);
      }
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
