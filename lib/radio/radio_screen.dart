import 'package:flutter/material.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          "assets/images/bg_radio_screen.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 212,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffE2BE7F),
                  ),
                  height: 133,
                  width: 390,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset("assets/icons/bg_radio_icon.png"),
                ),
                Column(
                  children: [
                    const Text(
                      "إذاعه القرآن الكريم",
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset("assets/icons/play_icon.png")
                  ],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
