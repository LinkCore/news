import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/extensions/build_context.dart';
import 'package:news/common/extensions/date_time.dart';
import 'package:news/common/extensions/text_style.dart';
import 'package:news/domain/news_cubit/news_cubit.dart';
import 'package:news/generated/l10n.dart';
import 'package:news/presentation/screens/news_list_page/widgets/article_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text(
              '${S.of(context).hello}${DateTime.now().convertDate}',
              style: context.textTheme.bodyMedium!.white,
            ),
            const Spacer(),
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsHasDataState) {
                  return Text(
                    '${S.of(context).news}${state.listNews.length}',
                    style: context.textTheme.bodyMedium!.white,
                  );
                } else {
                  return const SizedBox(
                    height: kToolbarHeight / 2,
                    width: kToolbarHeight / 2,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                      strokeWidth: 2,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          return switch (state) {
            NewsHasDataState d => ArticleListWidget(articles: d.listNews),
            NewsErrorState _ => Center(child: Text(state.errorCode)),
            _ => const Center(child: CircularProgressIndicator.adaptive()),
          };
        },
      ),
    );
  }
}
