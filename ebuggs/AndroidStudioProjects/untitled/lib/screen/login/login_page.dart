import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Home/Homepage.dart';
import 'otp_verification.dart';
import 'sign_up.dart';
import '../button/slideing_button.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  bool isLogin = true;
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (baseFontSize / 375);
  }

  Future<void> sendOtp(String phone) async {
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Verification failed: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() => isLoading = false);
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerificationCode(
                  phoneNumber: phone,
                  verificationId: verificationId,
                ),
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() => isLoading = false);
        },
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error sending OTP: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: isSmallScreen ? 20 : 40),

              // Logo
              SizedBox(
                height: screenHeight * 0.2,
                child: Image.asset(
                  'assets/images/Group 8731.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

              // Welcome Text
              Text(
                "Welcome to Ebuggs\nPlease enter your details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getResponsiveFontSize(context, 18),
                  fontFamily: "Inter",
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 30),

              // Login / Sign Up Toggle
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF243BCD),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isLogin = true),
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: isLogin ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: isLogin
                                  ? const Color(0xFF243BCD)
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: getResponsiveFontSize(context, 16),
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Registration(showBackButton: true),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: !isLogin ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: !isLogin
                                  ? const Color(0xFF243BCD)
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: getResponsiveFontSize(context, 16),
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Phone Field
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF243BCD)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    prefixIcon: Icon(
                      Icons.phone,
                      color: const Color(0xFF243BCD),
                      size: getResponsiveFontSize(context, 20),
                    ),
                    prefixText: "+91 ",
                    prefixStyle: TextStyle(
                      fontSize: getResponsiveFontSize(context, 16),
                      color: Colors.black,
                    ),
                    hintText: "Phone Number",
                    hintStyle: TextStyle(
                      fontSize: getResponsiveFontSize(context, 14),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or log in with",
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, 14),
                        color: Colors.grey.shade600,
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 1)),
                ],
              ),

              const SizedBox(height: 20),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.06,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF444444),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      icon: Image.asset(
                        'assets/images/devicon_google.png',
                        height: screenHeight * 0.03,
                      ),
                      label: Text(
                        "Google",
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.06,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF444444),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      icon: Image.asset(
                        'assets/images/logos_facebook.png',
                        height: screenHeight * 0.03,
                      ),
                      label: Text(
                        "Facebook",
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // ✅ Fixed Footer Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Guest Option
            GestureDetector(
              onTap: () {
                // Navigate to HomePage without back button
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Join as Guest",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: "Inter",
                      color: const Color(0xFF242424),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, color: Color(0xFF242424)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // OTP Button
            isLoading
                ? const CircularProgressIndicator(color: Color(0xFF243BCD))
                : Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    width: double.infinity,
                    child: CommonSlideButton(
                      text: "Get OTP",
                      onSubmit: () {
                        if (phoneController.text.length == 10) {
                          sendOtp(phoneController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please enter a valid 10-digit phone number",
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
