import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/model/news/article_model.dart';
import 'package:news/data/repositories/news_repository/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final NewsRepository _repository = NewsRepository();

  Future<void> loadNews({bool refresh = false}) async {
    if (refresh) emit(NewsInitial());
    try {
      List<ArticleModel> listNews = await _repository.loadNews(refresh);
      emit(NewsHasDataState(listNews: listNews));
    } on Exception catch (e) {
      emit(NewsErrorState(errorCode: e.toString()));
    }
  }

  Future<void> setRead(String id) async {
    await _repository.setReadById(id);
    emit(NewsHasDataState(listNews: List.from(_repository.news)));
  }
}
