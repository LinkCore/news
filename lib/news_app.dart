import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/screens/news_list_screen.dart';

import 'domain/news_cubit/news_cubit.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<NewsCubit>(
          create: (_) => NewsCubit()..loadNews(),
          child: const NewsListScreen(),
      ),
    );
  }
}