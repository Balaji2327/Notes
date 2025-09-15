import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:notes/homeScreen.dart';
import 'loginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),

              // 🔤 Heading
              Text(
                'Join us',
                style: TextStyle(
                  fontSize: width * 0.12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: height * 0.04),

              // 🔤 Full Name
              TextField(
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // ✉️ Email
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),

              // 🔒 Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              // ✅ Sign Up Button
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    // Add sign-up logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF81C784),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // 🔲 Checkbox
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'I agree with your conditions',
                      style: TextStyle(fontSize: width * 0.04),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.01),
              const Center(child: Text('Or')),
              SizedBox(height: height * 0.02),

              // 🔘 Social buttons
              SocialLoginButton(
                imagePath: 'assets/images/google.png',
                text: 'Continue with Google',
                fontSize: width * 0.04,
              ),
              SizedBox(height: height * 0.015),
              SocialLoginButton(
                imagePath: 'assets/images/github.png',
                text: 'GitHub',
                fontSize: width * 0.04,
              ),
              SizedBox(height: height * 0.015),
              SocialLoginButton(
                imagePath: 'assets/images/facebook.png',
                text: 'Facebook',
                fontSize: width * 0.04,
              ),

              const Spacer(),

              // 🔁 Navigate to Login Screen
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: width * 0.04,
                    ),
                    children: [
                      TextSpan(
                        text: 'Log in',
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
                                    builder: (context) => const LoginScreen(),
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
    );
  }
}

// 🔘 Social Login Button Widget
class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final double fontSize;

  const SocialLoginButton({
    super.key,
    required this.imagePath,
    required this.text,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          // Add social login logic
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: const BorderSide(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
