import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int currentIndex = 0; // لتتبع المحطة الحالية

  // رابط الـ API
  final String apiUrl = "https://data-rosy.vercel.app/radio.json";

  Radio? radioData;

  @override
  void initState() {
    super.initState();
    fetchRadioUrl(); // استدعاء الـ API لتحميل البيانات عند تحميل الشاشة
  }

  // استدعاء الـ API وتحميل البيانات
  Future<void> fetchRadioUrl() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // تحليل الاستجابة إلى نموذج Radio
        var data = json.decode(response.body);
        print('API Response: $data'); // طباعة الاستجابة للتأكد من صحتها

        setState(() {
          radioData = Radio.fromJson(data); // تعيين البيانات
        });
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('حدث خطأ: $e'),
      ));
    }
  }

  // دالة لتبديل تشغيل/إيقاف الراديو
  void togglePlayPause(String radioUrl) async {
    if (isPlaying) {
      await _audioPlayer.stop();
    } else {
      await _audioPlayer.play(UrlSource(radioUrl));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  // دالة للتبديل إلى المحطة التالية
  void nextStation() {
    if (radioData != null &&
        radioData!.radios != null &&
        radioData!.radios!.isNotEmpty) {
      setState(() {
        currentIndex = (currentIndex + 1) %
            radioData!.radios!.length; // الانتقال إلى المحطة التالية
      });

      // تشغيل المحطة الجديدة
      togglePlayPause(radioData!.radios![currentIndex].url!);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: radioData == null
          ? Center(child: CircularProgressIndicator()) // عرض مؤشر التحميل
          : Stack(
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
                    const SizedBox(height: 212),
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
                            // عرض اسم الإذاعة الحالية
                            radioData!.radios != null &&
                                    radioData!.radios!.isNotEmpty
                                ? Text(
                                    radioData!.radios![currentIndex]
                                        .name!, // عرض اسم الإذاعة
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )
                                : Text(
                                    "بيانات الإذاعة غير متوفرة",
                                    style: TextStyle(
                                        fontSize: 33,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // زر الـ "Previous"
                                IconButton(
                                  icon: Icon(Icons.skip_previous,
                                      size: 50, color: Colors.white),
                                  onPressed: () {
                                    if (radioData!.radios != null &&
                                        radioData!.radios!.isNotEmpty) {
                                      setState(() {
                                        currentIndex = (currentIndex -
                                                1 +
                                                radioData!.radios!.length) %
                                            radioData!.radios!
                                                .length; // العودة للمحطة السابقة
                                      });

                                      // تشغيل المحطة الجديدة
                                      togglePlayPause(radioData!
                                          .radios![currentIndex].url!);
                                    }
                                  },
                                ),
                                // زر الـ "Play/Pause"
                                InkWell(
                                  child: Image.asset(
                                    isPlaying
                                        ? "assets/icons/pause_icon.png"
                                        : "assets/icons/play_icon.png",
                                    height: 60, // نفس الحجم لكل الأيقونات
                                    width: 60, // نفس الحجم لكل الأيقونات
                                  ),
                                  onTap: () {
                                    if (radioData!.radios != null &&
                                        radioData!.radios!.isNotEmpty) {
                                      togglePlayPause(radioData!
                                          .radios![currentIndex].url!);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('رابط البث غير متوفر'),
                                      ));
                                    }
                                  },
                                ),
                                // زر الـ "Next"
                                IconButton(
                                  icon: Icon(Icons.skip_next,
                                      size: 50, color: Colors.white),
                                  onPressed:
                                      nextStation, // التبديل للمحطة التالية
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class Radio {
  List<Radios>? radios;

  Radio({this.radios});

  Radio.fromJson(Map<String, dynamic> json) {
    if (json['radios'] != null) {
      radios = <Radios>[];
      json['radios'].forEach((v) {
        radios!.add(Radios.fromJson(v));
      });
    }
  }
}

class Radios {
  int? id;
  String? name;
  String? url;
  String? img;

  Radios({this.id, this.name, this.url, this.img});

  Radios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    img = json['img'];
  }
}
