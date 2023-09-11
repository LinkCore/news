import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news/presentation/screens/concrete%20_news_screen.dart';

import '../../domain/news_cubit/news_cubit.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {

  String dateToString(DateTime dateTime) {
    String currentDateTime = _convertDate(dateTime);
    String nowDateTime = _convertDate(DateTime.now());
    String yesterday =
        _convertDate(DateTime.now().subtract(const Duration(days: 1)));

    if (currentDateTime == nowDateTime) {
      return 'сегодня в ${_convertTime(dateTime)}';
    } else if (currentDateTime == yesterday) {
      return 'вчера в ${_convertTime(dateTime)}';
    } else {
      return _convertDateTime(dateTime);
    }
  }

  String _convertDate(DateTime dateTime) =>
      DateFormat('dd.MM.yyyy').format(dateTime);

  String _convertTime(DateTime dateTime) =>
      DateFormat('kk:mm').format(dateTime);

  String _convertDateTime(DateTime dateTime) =>
      DateFormat('dd.MM.yyyy, kk:mm').format(dateTime);

  bool isNewPageLoading = false;

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


  void setupScrollListener(
      {required ScrollController scrollController,
        Function? onAtTop,
        Function? onAtBottom}) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        // Reach the top of the list
        if (scrollController.position.pixels == 0) {
          onAtTop?.call();
        }
        // Reach the bottom of the list
        else {
          onAtBottom?.call();
        }
      }
    });
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsHasDataState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF191919),
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    'Привет Егор, сегодня ${_convertDate(DateTime.now())}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  Text('Новостей: ${state.listNews.length}', style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            body: ListView(
              controller: scrollController,
                children: [...List.generate(
                    state.listNews.length,
                    (index) => InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ConcreteNewsScreen(
                                        news: state.listNews[index],
                                      ))),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15)
                                .copyWith(top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.listNews[index].title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 20),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(35),
                                    child: Image.network(
                                        state.listNews[index].urlToImage)),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      state.listNews[index].author,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                    const Spacer(),
                                    Text(
                                      dateToString(
                                          state.listNews[index].publishedAt),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.listNews[index].description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        )),
                  if(state.isLoading) const Center(child: CircularProgressIndicator()),]),
          );
        } else if (state is NewsErrorState) {
          return Text(state.errorCode);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
