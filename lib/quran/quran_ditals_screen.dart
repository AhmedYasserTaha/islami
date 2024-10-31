import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class QuranDitalsScreen extends StatefulWidget {
  QuranDitalsScreen({super.key, required this.index, required this.title});
  int index;
  String title;

  @override
  State<QuranDitalsScreen> createState() => _QuranDitalsScreenState();
}

class _QuranDitalsScreenState extends State<QuranDitalsScreen> {
  @override
  void initState() {
    super.initState();
    loadeFile();
  }

  List<String> verses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff202020),
        iconTheme: const IconThemeData(color: Color(0xffE2BE7F), size: 30),
        title: Text(
          widget.title,
          style: const TextStyle(
              fontSize: 25,
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
                              "${verses[index]} (${index + 1})",
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
                      itemCount: verses.length),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void loadeFile() async {
    String content =
        await rootBundle.loadString("assets/files/${widget.index}.txt");
    List<String> data = content.split("\n");
    verses = data;
    setState(() {});
  }
}
