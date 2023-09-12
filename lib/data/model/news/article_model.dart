import 'package:news/common/extensions/map.dart';
import 'package:news/generated/l10n.dart';

import 'article_model_keys.dart';

typedef _NewsKeys = NewsModelKeys;

class ArticleModel {
  final String title;
  final String description;
  final String content;
  final String author;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;

  int likes = 0;

  bool? _isRead;

  set isRead(bool value) => _isRead = value;

  bool get isRead => _isRead ?? false;

  ArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      author:
          json.valueFrom<String>(_NewsKeys.authorKey, S.current.unknownItem),
      title: json.valueFrom<String>(_NewsKeys.titleKey, S.current.unknownItem),
      description: json.valueFrom<String>(
          _NewsKeys.descriptionKey, S.current.unknownItem),
      url: json.valueFrom<String>(_NewsKeys.urlKey, S.current.unknownItem),
      urlToImage: json.valueFrom<String>(
          _NewsKeys.urlToImageKey, S.current.unknownItem),
      publishedAt: DateTime.tryParse(
            json.valueFrom<String>(
              _NewsKeys.publishedAtKey,
              '2023-09-07T16:01:16Z',
            ),
          ) ??
          DateTime.now(),
      content:
          json.valueFrom<String>(_NewsKeys.contentKey, S.current.unknownItem),
    );
  }
}
