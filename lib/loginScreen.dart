import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'signUpScreen.dart';
import 'forgetPassword.dart';
import 'otpVerification.dart';
import 'homeScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height - MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),

                    // Title
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: width * 0.12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      'It’s nice to see you again',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: height * 0.04),

                    // Username
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Your username or email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),

                    // Password
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.05),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.065,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF83C5BE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.015),

                    // OTP & Forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OtpLoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Log In with OTP?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const ForgetPasswordScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),
                    const Center(child: Text('Or')),
                    SizedBox(height: height * 0.03),

                    // Social Buttons
                    SocialLoginButton(
                      imagePath: 'assets/images/google.png',
                      text: 'Continue with Google',
                      fontSize: width * 0.04,
                    ),
                    SizedBox(height: height * 0.02),
                    SocialLoginButton(
                      imagePath: 'assets/images/github.png',
                      text: 'GitHub',
                      fontSize: width * 0.04,
                    ),
                    SizedBox(height: height * 0.02),
                    SocialLoginButton(
                      imagePath: 'assets/images/facebook.png',
                      text: 'Facebook',
                      fontSize: width * 0.04,
                    ),

                    const Spacer(),

                    // Sign up link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don’t have an account? ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: width * 0.04,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign up",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.04,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => const SignupScreen(),
                                        ),
                                      );
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 🔵 Social Login Button Widget
class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final double fontSize;

  const SocialLoginButton({
    Key? key,
    required this.imagePath,
    required this.text,
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: const BorderSide(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 24, width: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: fontSize)),
          ],
        ),
      ),
    );
  }
}
