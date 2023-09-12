import 'package:news/common/extensions/map.dart';
import 'package:news/data/model/news_source/article_model_sourse_keys.dart';

typedef _SKeys = ArticleModelSourceKeys;

class ArticleSourceModel {
  final String id;
  final String name;

  const ArticleSourceModel({
    required this.id,
    required this.name,
  });

  factory ArticleSourceModel.fromJson(Map<String, dynamic> json) {
    return ArticleSourceModel(
      id: json.valueFrom<String>(_SKeys.idKey, 'unknown'),
      name: json.valueFrom<String>(_SKeys.nameKey, 'unknown'),
    );
  }
}
