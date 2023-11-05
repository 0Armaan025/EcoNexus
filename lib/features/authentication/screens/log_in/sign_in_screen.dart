import 'package:econexus/common/custom_continue_button.dart';
import 'package:econexus/common/custom_text_field.dart';
import 'package:econexus/constants/constants.dart';
import 'package:econexus/features/authentication/controllers/auth_controller.dart';
import 'package:econexus/features/authentication/screens/sign_up/sign_up_screen.dart';
import 'package:econexus/features/home/screens/home_screen.dart';
import 'package:econexus/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/utils.dart';
import '../../../onboarding_screen/onboarding_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signIn(BuildContext context) {
    AuthController controller = AuthController();
    controller.logIn(context, _emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("$appName"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: size.height * 0.18,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1621106036911-964146b9f97c?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8d2VsY29tZSUyMGJhY2t8ZW58MHx8MHx8fDA%3D'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Welcome back! 👋🏻",
                      style: GoogleFonts.poppins(
                        color: AppTheme.headingTextColor,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "We are super excited to see you back 🔥",
                      style: GoogleFonts.roboto(
                        color: AppTheme.paragraphColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      isObscure: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "New to the app?",
                            style: GoogleFonts.poppins(
                                color: AppTheme.paragraphColor),
                          ),
                          InkWell(
                            onTap: () {
                              moveScreen(context, SignUpScreen(), true,
                                  isPushReplacement: true);
                            },
                            child: Text(
                              "\tSign up here!",
                              style: GoogleFonts.poppins(
                                color: AppTheme.paragraphColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                        child: CustomContinueButton(
                      onPressed: () {
                        signIn(context);
                      },
                      text: "Sign In!",
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
