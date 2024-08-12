import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BasePage extends StatelessWidget {
  final Widget child;

  const BasePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Lottie.asset("assets/background/normal_background.json",
                fit: BoxFit.cover),
          ),
          child,
        ],
      ),
    );
  }
}
