import 'package:flutter/material.dart';
import 'package:saegim/const/icon.dart';
import 'package:saegim/const/public_style.dart';
import 'package:saegim/screen/home_screen.dart';

class Header extends StatelessWidget {
  final String pageTitle;

  const Header({
    super.key,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 페이지 이름
          Text(
            pageTitle,
            style: textSize32,
          ),

          // 홈 버튼
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child,);
                  },
                  transitionDuration: const Duration(milliseconds: 1),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Image.asset(
              ImageConstants.iconHome,
              width: 26.0,
              height: 22.0,
            ),
          )
        ],
      ),
    );
  }
}