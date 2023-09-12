import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/model/news/article_model.dart';
import 'package:news/domain/news_cubit/news_cubit.dart';
import 'package:news/presentation/screens/news_list_page/widgets/article_item_widget.dart';

class ArticleListWidget extends StatefulWidget {
  const ArticleListWidget({
    required this.articles,
    super.key,
  });

  final List<ArticleModel> articles;

  @override
  State<ArticleListWidget> createState() => _ArticleListWidgetState();
}

class _ArticleListWidgetState extends State<ArticleListWidget> {
  final ScrollController controller = ScrollController();

  bool loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.addListener(() async {
      if (controller.offset > controller.position.maxScrollExtent * 0.8 &&
          !loading) {
        setState(() => loading = true);
        await context.read<NewsCubit>().loadNews();
        setState(() => loading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> articles = List.generate(
      widget.articles.length,
      (i) => ArticleItemWidget(model: widget.articles[i]),
    );
    if (loading) {
      articles.add(
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<NewsCubit>().loadNews(refresh: true),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        children: articles,
      ),
    );
  }
}
