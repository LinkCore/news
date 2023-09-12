import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/model/news/article_model.dart';
import 'package:news/domain/likes_cubit/likes_cubit.dart';
import 'package:news/domain/news_cubit/news_cubit.dart';
import 'package:news/presentation/screens/article_page/article_page.dart';
import 'package:news/presentation/screens/news_list_page/home_page.dart';

abstract class AppRoutes {
  static const homeRoute = 'home';
  static const articleRoute = 'article';

  static Route? onGenerateRoute(RouteSettings settings) {
    final Widget child;
    final NewsCubit newsCubit = NewsCubit();
    switch (settings.name) {
      case articleRoute:
        ArticleModel article = settings.arguments as ArticleModel;
        child = BlocProvider(
          create: (_) => LikesCubit(article.likes),
          child: ArticlePage(article: article),
        );
      default:
        child = BlocProvider(
          create: (_) => newsCubit..loadNews(),
          child: const HomePage(),
        );
    }
    return MaterialPageRoute(builder: (_) => child);
  }
}
