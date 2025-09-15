import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'signUpScreen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.03),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: height - MediaQuery.of(context).padding.top,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.04),

                      // Top Text
                      Text(
                        'Good bye\nbook & pen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.12, // responsive font
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      SizedBox(height: height * 0.03),

                      // Illustration
                      Image.asset(
                        'assets/images/front.png',
                        height: height * 0.35, // responsive image
                        fit: BoxFit.contain,
                      ),

                      SizedBox(height: height * 0.03),

                      // Bottom Text
                      Text(
                        'Hello,\noffered',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      SizedBox(height: height * 0.01),

                      // Subtext
                      Text(
                        'keep your information in our app',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: Colors.grey,
                        ),
                      ),

                      const Spacer(),

                      // Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.03,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.cyanAccent[400],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: height * 0.018,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: width * 0.045),
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.05),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent[400],
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: height * 0.018,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const SignupScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: width * 0.045),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
