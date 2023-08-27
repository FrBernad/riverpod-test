import 'package:fpdart/fpdart.dart';
import 'package:riverpodtest/features/emojis/data/datasources/remote/emoji_remote_data_source.dart';
import 'package:riverpodtest/features/emojis/data/entities/emoji_entity.dart';
import 'package:riverpodtest/features/emojis/domain/models/emoji_model.dart';

import '../../domain/repositories/emoji_repository.dart';

class EmojiRepositoryImpl implements EmojiRepository {
  final EmojiRemoteDataSource emojisRemoteDatasource;

  EmojiRepositoryImpl({
    required this.emojisRemoteDatasource,
  });

  @override
  Future<Emoji> getEmojiById({required String emojiId}) async {
    final Option<EmojiEntity> emojiEntityOpt =
        await emojisRemoteDatasource.getEmojiById(emojiId: emojiId);

    if (emojiEntityOpt.isNone()) {
      throw Exception();
    }

    return emojiEntityOpt.toNullable()!.toModel();
  }

  @override
  Future<List<Emoji>> getEmojis({required String? searchTerm}) async {
    final List<EmojiEntity> emojiEntities =
        await emojisRemoteDatasource.getEmojis(searchTerm: searchTerm);

    return emojiEntities.map((e) => e.toModel()).toList();
  }
}
