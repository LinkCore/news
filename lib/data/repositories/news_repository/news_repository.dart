import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/data/model/news/article_model.dart';
import 'package:news/data/repositories/news_repository/news_repository_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef _C = ApiConstants;

class NewsRepository {
  static final NewsRepository _newsRepository = NewsRepository._internal();

  factory NewsRepository() {
    return _newsRepository;
  }

  NewsRepository._internal();

  int _page = 1;

  final List<ArticleModel> _news = [];

  List<ArticleModel> get news => _news;

  Future<List<ArticleModel>> loadNews(bool refresh) async {
    if (refresh) {
      _news.clear();
      _page = 1;
    }
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
          .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
    for (var news in _news) {
      if (await _fetchReadById(news.url)) {
        news.isRead = true;
      }
      int likesCount = await _fetchLikeById(news.url);
      news.likes = likesCount;
    }
    return _news;
  }

  Future<bool> _fetchReadById(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool(id) ?? false;
  }

  Future<void> setReadById(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setBool(id, true);
    final int index = _news.indexWhere((element) => element.url == id);
    _news[index].isRead = true;
  }

  Future<int> _fetchLikeById(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getInt('$id.likes') ?? 0;
  }

  Future<int> setLikeById(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int index = _news.indexWhere((element) => element.url == id);
    _news[index].likes++;
    await sharedPreferences.setInt('$id.likes', _news[index].likes);
    return _news[index].likes;
  }
}
