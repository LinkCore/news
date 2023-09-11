import 'package:news/data/repository/news_repository.dart';

import '../../common/news_model_sourse_keys.dart';

typedef _SKeys = NewsModelSourceKeys;

class NewsModelSource {
  final String id;
  final String name;

  const NewsModelSource({
    required this.id,
    required this.name,
  });

  factory NewsModelSource.fromJson(Map<String, dynamic> json) {
    return NewsModelSource(
      id: json.valueFrom<String>(_SKeys.idKey, 'unknown'),
      name: json.valueFrom<String>(_SKeys.nameKey, 'unknown'),
    );
  }
}
