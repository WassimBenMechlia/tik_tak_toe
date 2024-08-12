import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tik_tak_toe/colors/app_colors.dart';
import 'package:tik_tak_toe/providers/user_choise_provider.dart';
import 'package:tik_tak_toe/shapes/circle_shape.dart';

import 'shapes/x_shape.dart';

class WelcomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      size: Size(200, 300),
                      painter: CircleShape(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      size: Size(200, 300),
                      painter: XShape(),
                    )),
              ),
            ],
          ),
          Text(
            "TIK-TAK-TOE",
            style: TextStyle(
                color: AppColors.mainColor,
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/select_shape');
              },
              style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 20)),
                  backgroundColor: WidgetStatePropertyAll(AppColors.mainColor)),
              child: const Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
