import 'package:flutter/material.dart';
import 'package:task/utils/validators.dart';
import 'package:task/views/registration/register_screen.dart';
import 'package:task/views/widgets/custom_button.dart';
import 'package:task/views/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 140, bottom: 180),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                TextFieldWidget(
                  textController: emailController,
                  hintText: "Enter your email",
                  validator: (value) => Validators.emailValidator(value),
                  icon: Icons.email,
                ),
                const SizedBox(height: 8),
                TextFieldWidget(
                  textController: emailController,
                  hintText: "Enter your password min 8 letters",
                  validator: (value) => Validators.passwordValidator(value),
                  icon: Icons.password,
                ),
                const SizedBox(height: 8),
                CustomButton(
                  text: "Login",
                  onTap: () {},
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
                                builder: (context) =>
                                    const RegsitrationScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Register',
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
    );
  }
}
