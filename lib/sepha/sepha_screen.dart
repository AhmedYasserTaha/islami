import 'package:flutter/material.dart';

class SephaScreen extends StatefulWidget {
  const SephaScreen({super.key});

  @override
  State<SephaScreen> createState() => _SephaScreenState();
}

class _SephaScreenState extends State<SephaScreen> {
  double counter = 0.0;
  int addCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          "assets/images/bg_sebha_screen.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(height: 70),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 105,
                    bottom: 285,
                    child: Image.asset(
                      "assets/icons/mask_group.png",
                      height: 90,
                      width: 90,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      counter += 100;
                      if (addCounter >= 99) {
                        addCounter = 0;
                      }
                      setState(() {
                        addCounter++;
                      });
                    },
                    child: Transform.rotate(
                      angle: counter,
                      child: Image.asset(
                        "assets/icons/sebhaaaaaaa.png",
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    retunString().toString(),
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    addCounter.toString(),
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  String retunString() {
    if (addCounter >= 0 && addCounter <= 33) {
      return "سبحان الله ";
    } else if (addCounter > 33 && addCounter <= 66) {
      return "الله أكبر";
    } else if (addCounter > 66 && addCounter <= 99) {
      return "الحمدالله";
    } else {
      return "";
    }
  }
}
