import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled/screen/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/2.png',
              fit: BoxFit.contain,
              width: size.width * 0.5,
            ),
            SizedBox(height: size.height * 0.02),

            // Brand Name
            Text(
              'Ebuggs',
              style: TextStyle(
                fontSize: 30,
                color: const Color(0xFF243BCD),
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),

            // Tagline
            Text(
              'Bid & Buy',
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF243BCD),
                fontFamily: "Inter",
              ),
            ),

          ],
        ),
      ),
    );
  }
}
