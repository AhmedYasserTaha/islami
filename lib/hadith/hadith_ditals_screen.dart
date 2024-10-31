import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HadithDitalsScreen extends StatefulWidget {
  HadithDitalsScreen(
      {super.key, required this.contentHadith, required this.title});
  List<String> contentHadith;
  String title;

  @override
  State<HadithDitalsScreen> createState() => _HadithDitalsScreenState();
}

class _HadithDitalsScreenState extends State<HadithDitalsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff202020),
        iconTheme: const IconThemeData(color: Color(0xffE2BE7F)),
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xffE2BE7F)),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg_quran_details_screen.png",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 125),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: const Color(0xffE2BE7F))),
                            child: Text(
                              widget.contentHadith[index],
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                      itemCount: widget.contentHadith.length),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
