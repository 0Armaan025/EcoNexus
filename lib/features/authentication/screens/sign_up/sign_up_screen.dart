import 'package:econexus/common/custom_continue_button.dart';
import 'package:econexus/common/custom_text_field.dart';
import 'package:econexus/constants/constants.dart';
import 'package:econexus/constants/utils.dart';
import 'package:econexus/features/authentication/controllers/auth_controller.dart';
import 'package:econexus/features/authentication/models/user.dart';
import 'package:econexus/features/authentication/screens/log_in/sign_in_screen.dart';
import 'package:econexus/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void signUp(BuildContext context) {
    AuthController controller = AuthController();
    UserModel model = UserModel(
      carbonEmissions: '0',
      city: _cityController.text,
      email: _emailController.text,
      eventsJoined: '0',
      name: _nameController.text,
      profileImage: '',
      password: _passwordController.text,
      relaxationTime: '0',
      uid: '',
    );

    controller.signUp(context, model);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                        'https://images.unsplash.com/photo-1520453803296-c39eabe2dab4?auto=format&fit=crop&q=80&w=2025&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
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
                      "Sign up time! ⏰",
                      style: GoogleFonts.poppins(
                        color: AppTheme.headingTextColor,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "We are excited to see new users!! 🤩",
                      style: GoogleFonts.roboto(
                        color: AppTheme.paragraphColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Name',
                      controller: _nameController,
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'City',
                      controller: _cityController,
                      isObscure: false,
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
                            "Already a user?",
                            style: GoogleFonts.poppins(
                                color: AppTheme.paragraphColor),
                          ),
                          InkWell(
                            onTap: () {
                              moveScreen(context, SignInScreen(), true,
                                  isPushReplacement: true);
                            },
                            child: Text(
                              "\tLog in here!",
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
                        signUp(context);
                      },
                      text: "Sign Up!",
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
