import 'package:flutter/material.dart';
import '../button/slideing_button.dart';
import 'login_page.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double responsiveFont(double size, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double fontSize = width * (size / 375);
    if (height < 600) fontSize *= 0.9;
    if (height > 900) fontSize *= 1.1;
    return fontSize.clamp(size * 0.8, size * 1.3);
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
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 Scrollable Middle Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.15),

                    // Logo
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: SizedBox(
                          width: size.width * 0.5,
                          height: size.width * 0.5,
                          child: Image.asset(
                            'assets/images/2.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.02),

                    // Brand Name
                    Text(
                      'Ebuggs',
                      style: TextStyle(
                        fontSize: responsiveFont(30, context),
                        color: const Color(0xFF243BCD),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                      ),
                    ),

                    // Tagline
                    Text(
                      'Bid & Buy',
                      style: TextStyle(
                        fontSize: responsiveFont(16, context),
                        color: const Color(0xFF243BCD),
                        fontFamily: "Inter",
                      ),
                    ),

                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            /// 🔹 Fixed Footer Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonSlideButton(
                text: "Get Started",
                onSubmit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginSignUpScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
