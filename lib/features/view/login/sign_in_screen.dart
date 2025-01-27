import 'package:flutter/material.dart';
import 'package:food_app/features/view/login/sign_up_screen.dart';
import '../../../utils/helper/auth_helper.dart';
import '../home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.pink.shade200,
        //   // centerTitle: true, //
        //   title: const Text(
        //     "SignIn",
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        //   ),
        // ),
        //
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/image/img.png",
                  height: 300,
                  width: 300,
                ),
                const Text(
                  'Sign In to your account',
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter valid data";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Enter valid email";
                    }
                    return null;
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
                    //
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String msg = await AuthHelper.helper
                          .signInWithEmailPassword(
                              txtEmail.text, txtPassword.text);
                      if (msg == "SignIn Successfully") {
                        AuthHelper.helper.checkUser();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
                        final snackBar = SnackBar(
                          content: const Text("Sign in Successfully"),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text("Signing in failed"),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: const Text('Sign In'),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    String msg = await AuthHelper.helper.signInWithGoogle();
                    if (msg == "SignIn Successfully") {
                      AuthHelper.helper.checkUser();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                      final snackBar = SnackBar(
                        action: SnackBarAction(
                          label: 'App',
                          onPressed: () {},
                        ),
                        content: const Text("Login successfully"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: const Text("Login Failed try Again"),
                        action: SnackBarAction(
                          label: "App",
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Card(
                    child: Image.asset(
                      'assets/image/google.png',
                      width: 230,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: const Text("Don't have an account? Sign Up"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}