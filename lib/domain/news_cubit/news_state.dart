part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

class NewsInitial extends NewsState {}

class NewsHasDataState extends NewsState {
  final List<ArticleModel> listNews;

  NewsHasDataState({
    required this.listNews,
  });
}

class NewsErrorState extends NewsState {
  final String errorCode;

  NewsErrorState({required this.errorCode});
}
