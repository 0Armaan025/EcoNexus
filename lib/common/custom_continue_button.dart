import 'package:econexus/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomContinueButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomContinueButton(
      {super.key, this.text = "Continue", required this.onPressed});

  @override
  State<CustomContinueButton> createState() => _CustomContinueButtonState();
}

class _CustomContinueButtonState extends State<CustomContinueButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height * 0.06,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.roboto(
            color: AppTheme.buttonTextColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
