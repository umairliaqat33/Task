// ignore_for_file: unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/models/employee/emp_model.dart';
import 'package:task/repositories/firestore_repository.dart';
import 'package:task/views/auth/login/login_screen.dart';
import 'package:task/views/emp_profile/emp_profile.dart';
import 'package:task/views/home/emp_information_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee App"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut();
              Fluttertoast.showToast(msg: 'Logout successful');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.settings_power,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EmployeeInformationScreen(),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<EmpModel?>>(
            stream: _firestoreRepository.getAllEmps(),
            builder: (context, snapshot) {
              if (snapshot.connectionState.name == 'waiting') {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              List<EmpModel?>? empList = snapshot.data;
              if (empList!.isEmpty) {
                return const Center(
                  child: Text(
                    "No Employee Data Found. Click + button to add employee data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }
              return GridView.builder(
                itemCount: empList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return EmpProfileScreen(
                              empModel: empList[index]!,
                            );
                          });
                    },
                    child: GridTile(
                      child: Center(
                        child: Image.network(
                          empList[index]!.imageLing,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
