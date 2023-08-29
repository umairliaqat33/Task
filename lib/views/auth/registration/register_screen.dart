// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/models/user/user_model.dart';
import 'package:task/repositories/auth_repository.dart';
import 'package:task/repositories/firestore_repository.dart';
import 'package:task/utils/exceptions.dart';
import 'package:task/utils/validators.dart';
import 'package:task/views/auth/login/login_screen.dart';
import 'package:task/views/home/home_screen.dart';
import 'package:task/views/widgets/custom_button.dart';
import 'package:task/views/widgets/text_field.dart';

class RegsitrationScreen extends StatefulWidget {
  const RegsitrationScreen({super.key});

  @override
  State<RegsitrationScreen> createState() => _RegsitrationScreenState();
}

class _RegsitrationScreenState extends State<RegsitrationScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 140, bottom: 180),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  TextFieldWidget(
                    textController: emailController,
                    obsecureText: false,
                    hintText: "Enter your email",
                    validator: (value) => Validators.emailValidator(value),
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 8),
                  TextFieldWidget(
                    obsecureText: true,
                    textController: passController,
                    hintText: "Enter your password min 8 letters",
                    validator: (value) => Validators.passwordValidator(value),
                    icon: Icons.password,
                  ),
                  const SizedBox(height: 8),
                  _showSpinner
                      ? const CircularProgressIndicator(
                          color: Colors.green,
                        )
                      : CustomButton(
                          text: "Register",
                          onTap: () => _register(
                            emailController.text,
                            passController.text,
                          ),
                        ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 34,
                        bottom: 19,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t Have an account? ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.green,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register(
    String email,
    String password,
  ) async {
    setState(() {
      _showSpinner = true;
    });
    AuthRepository auth = AuthRepository();
    FirestoreRepository firestoreRepository = FirestoreRepository();
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential? userCred = await auth.signUp(email, password);
        if (userCred != null) {
          setState(() {
            _showSpinner = true;
          });
          Fluttertoast.showToast(msg: "Registration Successful");

          firestoreRepository.postUserDetailstoFirestore(
            UserModel(uid: userCred.user!.uid, email: userCred.user!.email!),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        } else {
          setState(() {
            _showSpinner = true;
          });
          Fluttertoast.showToast(msg: "Login Failed");
        }
      } on EmailAlreadyExistException catch (e) {
        Fluttertoast.showToast(msg: e.message);
      } on UnknownException catch (e) {
        Fluttertoast.showToast(msg: e.message);
      }
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
