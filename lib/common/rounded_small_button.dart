import 'package:flutter/material.dart';
import 'package:mosaic_communities/theme/palette.dart';

class RoundedSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color bgColor;
  final Color txtColor;

  const RoundedSmallButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.bgColor = Pallete.whiteColor,
      this.txtColor = Pallete.backgroundColor
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Text(
          label,
          style: TextStyle(color: txtColor,fontSize: 16),
        ),
      ),
    );
  }
}
