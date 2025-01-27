import 'package:flutter/material.dart';

import '../../../utils/helper/auth_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/image/img.png",
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up to your account',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return null;
                    }
                  },
                  controller: txtEmail,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                  controller: txtPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String msg = await AuthHelper.helper
                          .signUpWithEmailPassword(
                          txtEmail.text, txtPassword.text);
                      if (msg == "Account Created Successfully") {
                        Navigator.pop(context);
                        final snackBar = SnackBar(
                          action: SnackBarAction(
                            label: 'Fitness App',
                            onPressed: () {},
                          ),
                          content: const Text("Account created Successfully"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          action: SnackBarAction(
                            label: 'Fitness App',
                            onPressed: () {},
                          ), content: const Text("Account creation failed"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // if (formKey.currentState!.validate()) {
                    //   Navigator.pop(context);
                    // }
                  },
                  child: const Text("Already have an account? Sign In"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}