class HomeData {
  String date;
  List<Story> stories;

  HomeData({this.date, this.stories});

  HomeData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['stories'] != null) {
      stories = new List<Story>();
      json['stories'].forEach((v) {
        stories.add(new Story.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.stories != null) {
      data['stories'] = this.stories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Story {
  List<String> images;
  int type;
  int id;
  String gaPrefix;
  String title;

  Story({this.images, this.type, this.id, this.gaPrefix, this.title});

  Story.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    type = json['type'];
    id = json['id'];
    gaPrefix = json['ga_prefix'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['type'] = this.type;
    data['id'] = this.id;
    data['ga_prefix'] = this.gaPrefix;
    data['title'] = this.title;
    return data;
  }
}
