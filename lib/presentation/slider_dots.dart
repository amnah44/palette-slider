import 'package:flutter/material.dart';

class SliderDots extends StatelessWidget {
  SliderDots({Key? key, required this.isActive}) : super(key: key);

  bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      height: isActive ? 12 : 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
          color: isActive? Colors.black54 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black
        )
      ),
    );
  }
}
