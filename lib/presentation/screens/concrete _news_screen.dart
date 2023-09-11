import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/model/news_model.dart';

class ConcreteNewsScreen extends StatelessWidget {
  final NewsModel news;

  const ConcreteNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF191919),
        title: Text(
          news.title,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.network(news.urlToImage)),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  news.author,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
                const Spacer(),
                Text(
                  DateFormat('dd.MM.yyyy, kk:mm').format(news.publishedAt),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(news.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            Text(news.content,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            InkWell(child: Text(news.url))
          ],
        ),
      ),
    );
  }
}
