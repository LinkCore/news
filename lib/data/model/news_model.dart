import 'package:news/common/map_extension.dart';

import '../../common/news_model_keys.dart';

typedef _NewsKeys = NewsModelKeys;

class NewsModel {
  final String title;
  final String description;
  final String content;
  final String author;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  bool? _isRead;
  int likes = 0;

  NewsModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  set isRead(bool value) => _isRead = value;

  bool get isRead => _isRead ?? false;

  @override
  String toString() {
    return 'NewsModel{title: $title, description: $description, content: $content, author: $author, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, _isRead: $_isRead}';
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json.valueFrom<String>(_NewsKeys.authorKey, 'unknown'),
      title: json.valueFrom<String>(_NewsKeys.titleKey, 'unknown'),
      description: json.valueFrom<String>(_NewsKeys.descriptionKey, 'unknown'),
      url: json.valueFrom<String>(_NewsKeys.urlKey, 'unknown'),
      urlToImage: json.valueFrom<String>(_NewsKeys.urlToImageKey, 'unknown'),
      publishedAt: DateTime.tryParse(
            json.valueFrom<String>(
              _NewsKeys.publishedAtKey,
              '2023-09-07T16:01:16Z',
            ),
          ) ??
          DateTime.now(),
      content: json.valueFrom<String>(_NewsKeys.contentKey, 'unknown'),
    );
  }
}
