import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/app_routes/app_routes.dart';
import 'package:news/common/extensions/build_context.dart';
import 'package:news/common/extensions/text_style.dart';
import 'package:news/data/model/news/article_model.dart';
import 'package:news/domain/news_cubit/news_cubit.dart';
import 'package:news/presentation/common/published.dart';
import 'package:news/presentation/common/reading_time.dart';

class ArticleItemWidget extends StatefulWidget {
  const ArticleItemWidget({
    required this.model,
    super.key,
  });

  final ArticleModel model;

  @override
  State<ArticleItemWidget> createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {
  void onTap(ArticleModel article) async {
    Navigator.of(context).pushNamed(AppRoutes.articleRoute, arguments: article);
    await context.read<NewsCubit>().setRead(article.url);
  }

  @override
  Widget build(BuildContext context) {
    Color textColor =
        widget.model.isRead ? Colors.black87.withOpacity(0.3) : Colors.black87;
    return Stack(
      children: [
        InkWell(
          onTap: () => onTap(widget.model),
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.title,
                  style: context.textTheme.displaySmall!.medium
                      .withColor(textColor),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.model.urlToImage,
                      ),
                      Visibility(
                        visible: widget.model.isRead,
                        child: Positioned.fill(
                          child: Container(color: Colors.grey.withOpacity(0.5)),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                PublicationWidget(
                  author: widget.model.author,
                  publishedAt: widget.model.publishedAt,
                  disabled: widget.model.isRead,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.model.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      context.textTheme.bodyMedium!.medium.withColor(textColor),
                ),
                const SizedBox(height: 5),
                ReadingTimeWidget(
                  title: widget.model.title,
                  content: widget.model.content,
                  disabled: widget.model.isRead,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
