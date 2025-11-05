import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signUpScreen.dart';
import 'forgetPassword.dart';
import 'otpVerification.dart';
import 'homeScreen.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() => _loading = true);
    try {
      final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_email', userCred.user?.email ?? email);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Authentication failed. Please try again.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login error: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.03),

                  // 🔤 Heading
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: width * 0.12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: height * 0.04),

                  // ✉️ Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.025),

                  // 🔒 Password
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: height * 0.04),

                  // 🔘 Login Button
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
                      onPressed: _loading ? null : _signIn,
                      child:
                          _loading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
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

                  // 🔗 OTP & Forgot Password
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
                  SizedBox(height: height * 0.02),

                  // 🟢 Social Login Buttons
                  SocialLoginButton(
                    imagePath: 'assets/images/google.png',
                    text: 'Continue with Google',
                    fontSize: width * 0.04,
                    onPressed: () async {
                      setState(() => _loading = true);
                      try {
                        final cred = await AuthService.signInWithGoogle();
                        if (cred != null) {
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Google sign-in cancelled'),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google sign-in failed: $e')),
                        );
                      } finally {
                        if (mounted) setState(() => _loading = false);
                      }
                    },
                  ),
                  SizedBox(height: height * 0.015),
                  SocialLoginButton(
                    imagePath: 'assets/images/github.png',
                    text: 'GitHub',
                    fontSize: width * 0.04,
                    onPressed: () async {
                      setState(() => _loading = true);
                      try {
                        final cred = await AuthService.signInWithGitHub();
                        if (cred != null) {
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('GitHub sign-in cancelled'),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code ==
                                'account-exists-with-different-credential' ||
                            e.code == 'credential-already-in-use') {
                          final email = e.email;

                          // Offer to sign in with Google to link accounts
                          showDialog(
                            context: context,
                            builder:
                                (ctx) => AlertDialog(
                                  title: const Text('Account exists'),
                                  content: Text(
                                    'An account already exists with the same email (${email ?? 'unknown'}).\n'
                                    'Sign in with Google to link your GitHub account.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(ctx).pop();
                                        try {
                                          final g =
                                              await AuthService.signInWithGoogle();
                                          if (g != null) {
                                            // Now run the GitHub linking flow for the signed-in user
                                            try {
                                              final linked =
                                                  await AuthService.linkGitHubToCurrentUser();
                                              if (linked != null && mounted) {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const HomeScreen(),
                                                  ),
                                                );
                                              }
                                            } catch (linkErr) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Failed to link GitHub: $linkErr',
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        } catch (signErr) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Sign-in with provider failed: $signErr',
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Sign in & Link'),
                                    ),
                                  ],
                                ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'GitHub sign-in failed: ${e.message}',
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('GitHub sign-in failed: $e')),
                        );
                      } finally {
                        if (mounted) setState(() => _loading = false);
                      }
                    },
                  ),
                  SizedBox(height: height * 0.015),
                  SocialLoginButton(
                    imagePath: 'assets/images/facebook.png',
                    text: 'Facebook',
                    fontSize: width * 0.04,
                  ),

                  const SizedBox(height: 20),

                  // 🔁 Navigate to Sign Up Screen (Updated Font)
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          fontFamily: 'Poppins', // ✅ Same as SignupScreen
                          color: Colors.black,
                          fontSize: width * 0.04,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              fontFamily: 'Poppins', // ✅ Same font family
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
    );
  }
}

// 🔵 Reusable Social Login Button (same as SignupScreen)
class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final double fontSize;
  final VoidCallback? onPressed;

  const SocialLoginButton({
    super.key,
    required this.imagePath,
    required this.text,
    this.fontSize = 16,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
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
