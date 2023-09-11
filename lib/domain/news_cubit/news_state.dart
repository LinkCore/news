part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsHasDataState extends NewsState {
  final List<NewsModel> listNews;
  final bool isLoading;

  NewsHasDataState({required this.listNews, this.isLoading = false});
}

class NewsErrorState extends NewsState {
  final String errorCode;

  NewsErrorState({required this.errorCode});
}
