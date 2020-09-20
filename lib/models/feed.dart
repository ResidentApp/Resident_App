class Feed {
  String id;
  String title;
  String description;
  String imgURL;
  List upvotes;
  List downvotes;
  List flags;

  Feed(String _id, String title, String description, String imgURL,
      List upvotes, List downvotes, List flags) {
    this.id = _id;
    this.title = title;
    this.description = description;
    this.imgURL = imgURL;
    this.upvotes = upvotes;
    this.downvotes = downvotes;
    this.flags = flags;
  }

  Feed.fromJson(Map json)
      : id = json['_id'],
        title = json['title'],
        description = json['description'],
        imgURL = json['imgURL'],
        upvotes = json['upvotes'],
        downvotes = json['downvotes'],
        flags = json['flags'];

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imgURL': imgURL,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'flags': flags
    };
  }
}
