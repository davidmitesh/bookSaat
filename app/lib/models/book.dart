class Book {
  Author author;
  Category category;
  String sId;
  String bookId;
  String title;
  String imgUrl;

  Book(
      {this.author,
      this.category,
      this.sId,
      this.bookId,
      this.title,
      this.imgUrl});

  Book.fromJson(Map<String, dynamic> json) {
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    sId = json['_id'];
    bookId = json['bookId'];
    title = json['title'];
    imgUrl = json['imgUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['_id'] = this.sId;
    data['bookId'] = this.bookId;
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    return data;
  }
}

class Author {
  String authId;
  String authName;

  Author({this.authId, this.authName});

  Author.fromJson(Map<String, dynamic> json) {
    authId = json['authId'];
    authName = json['authName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authId'] = this.authId;
    data['authName'] = this.authName;
    return data;
  }
}

class Category {
  String catId;
  String catName;

  Category({this.catId, this.catName});

  Category.fromJson(Map<String, dynamic> json) {
    catId = json['catId'];
    catName = json['catName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catId'] = this.catId;
    data['catName'] = this.catName;
    return data;
  }
}
