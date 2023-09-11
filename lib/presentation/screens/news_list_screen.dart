import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/screens/concrete%20_news_screen.dart';

import '../../common/app_strings.dart';
import '../../common/helper_methods.dart';
import '../../data/model/news_model.dart';
import '../../domain/news_cubit/news_cubit.dart';
import '../widgets/published.dart';
import '../widgets/reading_time.dart';

typedef _S = AppStrings;
typedef _H = HelperMethods;

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final ScrollController scrollController = ScrollController();
  bool isNewPageLoading = false;

  void setupScrollListener(
      {required ScrollController scrollController,
      Function? onAtTop,
      Function? onAtBottom}) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          onAtTop?.call();
        } else {
          onAtBottom?.call();
        }
      }
    });
  }

  void tapOnNews(NewsModel index, String url) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConcreteNewsScreen(
              news: index,
            )));
    await context.read<NewsCubit>().setRead(url);
  }

  @override
  void initState() {
    setupScrollListener(
      scrollController: scrollController,
      onAtBottom: () async {
        isNewPageLoading = true;
        await context.read<NewsCubit>().loadNews();
        isNewPageLoading = false;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsHasDataState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    '${_S.hello}${_H.convertDate(DateTime.now())}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Text('${_S.news}${state.listNews.length}',
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            body: ListView(controller: scrollController, children: [
              ...List.generate(
                  state.listNews.length,
                  (index) => InkWell(
                        onTap: () => tapOnNews(
                            state.listNews[index], state.listNews[index].url),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15)
                              .copyWith(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.listNews[index].title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: state.listNews[index].isRead
                                      ? Colors.black87.withOpacity(0.3)
                                      : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 20),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: CachedNetworkImage(
                                    imageUrl: state.listNews[index].urlToImage,
                                  )),
                              const SizedBox(height: 5),
                              Publication(
                                author: state.listNews[index].author,
                                publishedAt: state.listNews[index].publishedAt,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                state.listNews[index].content,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 13),
                              ),
                              const SizedBox(height: 5),
                              ReadingTime(
                                title: state.listNews[index].title,
                                content: state.listNews[index].content,
                                description: state.listNews[index].description,
                              ),
                            ],
                          ),
                        ),
                      )),
              if (state.isLoading)
                const Padding(
                    padding: EdgeInsets.only(top: 300),
                    child: Center(
                        child: CircularProgressIndicator(strokeAlign: 40))),
            ]),
          );
        } else if (state is NewsErrorState) {
          return Center(child: Text(state.errorCode));
        } else {
          return const Center(child: Text(_S.unknownState));
        }
      },
    );
  }
}
