import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/data/repositories/news_repository/news_repository.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikeState> {
  LikesCubit(this.initialLikesCount)
      : super(LikeState(like: initialLikesCount));

  final int initialLikesCount;

  final NewsRepository _repository = NewsRepository();

  Future<void> addLike(String id) async {
    emit(LikeState(like: await _repository.setLikeById(id)));
  }
}
