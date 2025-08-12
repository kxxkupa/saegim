import 'package:flutter/material.dart';
import 'package:saegim/const/icon.dart';

class CircleAdd extends StatelessWidget {
  const CircleAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.0,
      right: 0,
      child: GestureDetector(
        onTap: () {
        
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1),
                blurRadius: 10.0,
                color: Color(0xFF000000).withValues(alpha: 0.25),
              ),
            ],
          ),
          child: Image.asset(
            ImageConstants.iconAdd,
            width: 60.0,
            height: 60.0,
          ),
        ),
      ),
    );
  }
}