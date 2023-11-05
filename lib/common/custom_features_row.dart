import 'package:flutter/material.dart';

import 'custom_card_widget.dart';

class CustomFeaturesRow extends StatefulWidget {
  const CustomFeaturesRow({super.key});

  @override
  State<CustomFeaturesRow> createState() => _CustomFeaturesRowState();
}

class _CustomFeaturesRowState extends State<CustomFeaturesRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCardWidget(
          onTap: () {},
          bgColor: Colors.blue,
          textColor: Colors.white,
          text: "Something",
          imageUrl:
              'https://plus.unsplash.com/premium_photo-1666345061648-d5f55842a515?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZWNvJTIwcHJvamVjdHxlbnwwfHwwfHx8MA%3D%3D',
        ),
      ],
    );
  }
}
