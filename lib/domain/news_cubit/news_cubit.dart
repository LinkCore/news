import 'package:flutter/material.dart';
import 'package:news/data/repository/news_repository.dart';

import '../../data/model/news_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final NewsRepository _repository = NewsRepository();

  Future<void> loadNews() async {
    emit(NewsHasDataState(listNews: _repository.news, isLoading: true));
    try{
      List<NewsModel> listNews = await _repository.loadNews();
      emit(NewsHasDataState(listNews: listNews));
    } on Exception catch (e) {
      emit(NewsErrorState(errorCode: e.toString()));
    }
  }
}
