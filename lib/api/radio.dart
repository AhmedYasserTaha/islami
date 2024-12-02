class Radio {
  List<Radios>? radios;

  Radio({this.radios});

  Radio.fromJson(Map<String, dynamic> json) {
    if (json['radios'] != null) {
      radios = <Radios>[];
      json['radios'].forEach((v) {
        radios!.add(new Radios.fromJson(v));
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
