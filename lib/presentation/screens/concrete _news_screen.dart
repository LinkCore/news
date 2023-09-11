import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/likes_cubit/likes_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/app_strings.dart';
import '../../data/model/news_model.dart';
import '../widgets/published.dart';
import '../widgets/reading_time.dart';

typedef _S = AppStrings;

class ConcreteNewsScreen extends StatelessWidget {
  final NewsModel news;

  const ConcreteNewsScreen({super.key, required this.news});

  void openOnWeb() async => await launchUrl(Uri.parse(news.url));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikesCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(news.title,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: CachedNetworkImage(imageUrl: news.urlToImage)),
                  const SizedBox(height: 10),
                  ReadingTime(
                    title: news.title,
                    content: news.content,
                    description: news.description,
                  ),
                  const SizedBox(height: 5),
                  Publication(
                    author: news.author,
                    publishedAt: news.publishedAt,
                  ),
                  const SizedBox(height: 40),
                  Text(news.content,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Text(news.description,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Spacer(),
                      BlocBuilder<LikesCubit, LikeState>(
                        builder: (context, state) {
                          return Text('${_S.countOfLikes}${state.like}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                              )
                          );
                        },
                      ),
                      IconButton(
                          onPressed: () =>
                              context.read<LikesCubit>().addLike(news.url),
                          icon: const Icon(Icons.favorite)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                      onTap: openOnWeb,
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF191919),
                          ),
                          child: const Text(
                            _S.openOnWeb,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ))),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
