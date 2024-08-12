import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tik_tak_toe/colors/app_colors.dart';
import 'package:tik_tak_toe/providers/user_choise_provider.dart';
import 'package:tik_tak_toe/shapes/circle_shape.dart';

import 'shapes/x_shape.dart';

class SelectShape extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(size: 40, color: AppColors.mainColor),
        title: Text(
          "SHOOSE A SIDE",
          style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 35,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          InkWell(
            onTap: () {
              ref.read(userChoiseProvider.notifier).playersChoise('x');
              Navigator.pushNamed(context, '/board');
            },
            child: Container(
              padding: const EdgeInsets.all(60.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: CustomPaint(
                  size: Size(200, 300),
                  painter: XShape(),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ref.read(userChoiseProvider.notifier).playersChoise('o');
              Navigator.pushNamed(context, '/board');
            },
            child: Container(
              padding: const EdgeInsets.all(60.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: CustomPaint(
                  size: Size(200, 300),
                  painter: CircleShape(),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
