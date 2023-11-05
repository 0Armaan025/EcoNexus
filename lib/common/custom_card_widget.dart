import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/Theme.dart';

class CustomCardWidget extends StatefulWidget {
  final Color bgColor;
  final Color textColor;
  final String text;
  final String imageUrl;
  final VoidCallback onTap;
  const CustomCardWidget(
      {super.key,
      required this.bgColor,
      required this.textColor,
      required this.text,
      required this.onTap,
      required this.imageUrl});

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.38,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Image(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.text,
            style: GoogleFonts.poppins(
              color: widget.textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: widget.onTap,
            child: Container(
              height: size.height * 0.05,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppTheme.buttonColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.roboto(
                  color: AppTheme.buttonTextColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
