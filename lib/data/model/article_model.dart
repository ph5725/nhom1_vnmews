// class ArticleModel {
//   String? source;
//   String? author;
//   String? title;
//   String? description;
//   String? url;
//   String? urlToImage;
//   String? publishedAt;
//   String? content;

//   //constructor
//   ArticleModel({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content});

//   ArticleModel.fromJson(Map<String, dynamic> json) {
//     source = json['source'];
//     author = json['author'];
//     title = json['title'];
//     description = json['description'];
//     url = json['url'];
//     urlToImage = json['urlToImage'];
//     publishedAt = json['publishedAt'];
//     content = json['content'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic> {};

//     // if (source != null) {
//     //   data['source'] = source!.toJson();
//     // }

//     data["source"] = source;
//     data["author"] = author;
//     data["title"] = title;
//     data["description"] = description;
//     data["url"] = url;
//     data["urlToImage"] = urlToImage;
//     data["publishedAt"] = publishedAt;
//     data["content"] = content;

//     return data;
//   }
// }