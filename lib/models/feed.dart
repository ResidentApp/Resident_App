class Feed {
  String id;
  String title;
  String description;
  String imgURL;

  Feed(String _id, String title,String description, String imgURL) {
    this.id = _id;
    this.title = title;
    this.description = description;
    this.imgURL = imgURL;
  }

  Feed.fromJson(Map json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        imgURL = json['imgURL'];

  Map toJson() {
    return {'id': id, 'title': title, 'description': description, 'imgURL':imgURL};
  }
}