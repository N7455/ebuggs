import 'package:flutter/material.dart';
import '../Home/Homepage.dart';
import '../button/slideing_button.dart';
import 'login_page.dart';

class Registration extends StatefulWidget {
  final bool showBackButton;
  const Registration({super.key, this.showBackButton = true});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  bool isLoading = false;
  bool isLoginSelected = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  double responsiveFont(double size) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double fontSize = width * (size / 375);
    if (height < 600) fontSize *= 0.9;
    if (height > 900) fontSize *= 1.1;
    return fontSize.clamp(size * 0.8, size * 1.3);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        leading: widget.showBackButton
            ? GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 25,
          ),
        )
            : null,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: h * 0.02),

              // Top Image
              SizedBox(
                
                height: h * 0.20,
                child: Image.asset('assets/images/lady.png'),
              ),
              SizedBox(height: h * 0.03),

              // Log In / Sign Up Toggle
              Container(
                height: h * 0.055,
                decoration: BoxDecoration(
                  color: const Color(0xFF243BCD),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isLoginSelected = true); // optional, for UI highlight
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginSignUpScreen()), // replace with your login page
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isLoginSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: isLoginSelected ? const Color(0xFF243BCD) : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: responsiveFont(16),
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isLoginSelected = false); // optional
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: !isLoginSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: !isLoginSelected ? const Color(0xFF243BCD) : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: responsiveFont(16),
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: h * 0.025),

              // Input Fields
              _buildTextField(Icons.person, "Enter Name", nameController),
              SizedBox(height: h * 0.015),
              _buildTextField(Icons.email, "Enter Email", emailController),
              SizedBox(height: h * 0.015),
              _buildTextField(Icons.phone, "Enter Phone Number", phoneController),
              SizedBox(height: h * 0.015),
              _buildTextField(Icons.location_on, "Enter Address", addressController),
              SizedBox(height: h * 0.025),

              // Or log in with divider
              Row(
                children: [
                  const Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or log in with",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: responsiveFont(14),
                      ),
                    ),
                  ),
                  const Expanded(child: Divider(thickness: 2)),
                ],
              ),
              SizedBox(height: h * 0.02),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _socialLoginButton("Google", "assets/images/devicon_google.png"),
                  _socialLoginButton("Facebook", "assets/images/logos_facebook.png"),
                ],
              ),
              SizedBox(height: h * 0.04),

              // Continue Slide Button
              CommonSlideButton(
                text: isLoading ? "Please wait..." : "Continue",
                isLoading: isLoading,
                onSubmit: () {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }

                  // Navigate to HomePage without showing back button
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(String label, String assetPath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF243BCD)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Image.asset(assetPath, height: 20, width: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hint, TextEditingController controller,
      {bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF243BCD)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
          color: const Color(0xFF243BCD).withOpacity(0.8),
          fontFamily: "Inter",
        ),
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF243BCD)),
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
