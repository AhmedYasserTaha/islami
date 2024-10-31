import 'package:flutter/material.dart';
import 'package:islami_app/quran/quran_ditals_screen.dart';

class QuranItemsWidget extends StatelessWidget {
  const QuranItemsWidget({
    super.key,
    required this.title,
    required this.number,
  });
  final String title;
  final int number;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuranDitalsScreen(
            title: title,
            index: number,
          ),
        ));
      },
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset("assets/icons/number_shap_icon.png"),
              Text(
                "$number",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
