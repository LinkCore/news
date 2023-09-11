import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/news_repository.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikeState> {
  LikesCubit() : super(LikeState(like: 0));

  final NewsRepository _repository = NewsRepository();


  Future<void> addLike(String id) async {
    emit(LikeState(like: await _repository.addLike(id)));
  }
}
