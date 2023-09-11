import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common/api_constants.dart';
import '../model/news_model.dart';

typedef _C = ApiConstants;

class NewsRepository {
  static final NewsRepository _newsRepository = NewsRepository._internal();

  factory NewsRepository() {
    return _newsRepository;
  }

  NewsRepository._internal();

  int _page = 1;

  final List<NewsModel> _news = [];

  List<NewsModel> get news => _news;

  Future<List<NewsModel>> loadNews() async {
    final rawResponse = await http.get(
      Uri.parse(
        '${_C.endpoint}&page=$_page&apiKey=${_C.apiKey}',
      ),
    );

    if (rawResponse.statusCode != 200) {
      throw Exception('incorrect server response: ${rawResponse.statusCode}');
    }
    final Object? rawList = jsonDecode(rawResponse.body);

    if (rawList is! Map<String, dynamic>) {
      throw Exception('incorrect server response: ${rawResponse.body}');
    }

    _page++;
    _news.addAll(
      (rawList[_C.articlesKey] as List)
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    return _news;
  }
}

extension MapExtension on Map<String, dynamic> {
  T valueFrom<T>(String key, T placeholder) {
    if (keys.contains(key) && this[key] is T) {
      return this[key] as T;
    } else {
      return placeholder;
    }
  }
}
