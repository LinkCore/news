import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/extensions/build_context.dart';
import 'package:news/common/extensions/text_style.dart';
import 'package:news/data/model/news/article_model.dart';
import 'package:news/domain/likes_cubit/likes_cubit.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/presentation/common/published.dart';
import 'package:news/presentation/common/reading_time.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final ArticleModel article;

  const ArticlePage({
    required this.article,
    super.key,
  });

  void openOnWeb() async => await launchUrl(Uri.parse(article.url));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          article.title,
          style: context.textTheme.bodySmall!.white.medium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
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
                  child: CachedNetworkImage(imageUrl: article.urlToImage)),
              const SizedBox(height: 10),
              ReadingTimeWidget(
                title: article.title,
                content: article.content,
              ),
              const SizedBox(height: 5),
              PublicationWidget(
                author: article.author,
                publishedAt: article.publishedAt,
              ),
              const SizedBox(height: 40),
              Text(
                article.content,
                style: context.textTheme.bodyLarge!.medium,
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
                  child: Text(
                    S.of(context).openOnWeb,
                    textAlign: TextAlign.center,
                    style: context.textTheme.displaySmall!.medium
                        .withColor(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<LikesCubit, LikeState>(
                    builder: (context, state) {
                      return Text(
                        '${S.of(context).countOfLikes}${state.like}',
                        style: context.textTheme.bodyMedium!.bold,
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<LikesCubit>().addLike(article.url),
                    icon: const Icon(Icons.favorite),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
