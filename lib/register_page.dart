import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uphill/home_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    userController.addListener(() {
      setState(() {});
    });

    passwordController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage(
                    'assets/images/hiker.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logo.png', // Replace with your logo image path
                      width: screenHeight * 0.25,
                      height: screenWidth * 0.25,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.04,
                      bottom: screenHeight * 0.02,
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Username",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Abel',
                              fontSize: 20),
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, right: 10, left: 14),
                            child: Image.asset(
                              'assets/images/username.png',
                              scale: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.02,
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: TextFormField(
                        controller: userController,
                        autofocus: false,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Email",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Abel',
                              fontSize: 20),
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, right: 10, left: 14),
                            child: Image.asset(
                              'assets/images/username.png',
                              scale: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.02,
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: TextFormField(
                        controller: passwordController,
                        autofocus: false,
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Password",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Abel',
                              fontSize: 20),
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, right: 10, left: 14),
                            child: Image.asset(
                              'assets/images/password.png',
                              scale: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.08,
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: TextFormField(
                        autofocus: false,
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Repeat Password",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Abel',
                              fontSize: 20),
                          prefixIcon: Container(
                            padding: const EdgeInsets.only(
                                top: 6, bottom: 6, right: 10, left: 14),
                            child: Image.asset(
                              'assets/images/password.png',
                              scale: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: screenHeight * 0.10,
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: userController.text,
                                password: passwordController.text)
                            .then((value) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const HomePage()));
                        }).onError((error, stackTrace) {
                          showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                    content: Text(
                                        'Invalid email address or password'),
                                  ));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // Set button color to green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
