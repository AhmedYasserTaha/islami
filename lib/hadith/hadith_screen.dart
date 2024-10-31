import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/hadith/hadith_ditals_screen.dart';
import 'package:islami_app/hadith/widget/hadith_iteam_widget.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  List<Hadtih> hadithList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFileMads();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          "assets/images/bg_quran_and_hadith_screen.png",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                height: 230,
                width: 100,
                child: Image.asset("assets/icons/bg_hadith_icon.png"),
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => const Divider(),
                  itemCount: hadithList.length,
                  separatorBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HadithDitalsScreen(
                            title: hadithList[index].title,
                            contentHadith: hadithList[index].content,
                          ),
                        ));
                      },
                      child: HadithIteamWidget(
                        title: hadithList[index].title,
                      )),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void readFileMads() async {
    String content = await rootBundle.loadString("assets/ahadeth.txt");
    List<String> contentHadithList = content.split("#\r\n");

    for (var i = 0; i < contentHadithList.length; i++) {
      List<String> splitDetails = contentHadithList[i].split("\n");

      String title = splitDetails[0];
      splitDetails.removeAt(0);
      var hadithContent = Hadtih(content: splitDetails, title: title);
      hadithList.add(hadithContent);
    }
    setState(() {});
  }
}

class Hadtih {
  String title;
  List<String> content;
  Hadtih({required this.content, required this.title});
}
