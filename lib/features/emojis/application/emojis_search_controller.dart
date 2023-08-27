import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtest/features/emojis/providers.dart';

import '../domain/models/emoji_model.dart';

part 'generated/emojis_search_controller.g.dart';

@riverpod
class EmojisSearchController extends _$EmojisSearchController {
  Timer? _debounceTimer;

  @override
  Future<List<Emoji>> build() async {
    ref.onDispose(() {
      if (_debounceTimer != null) _debounceTimer!.cancel();
    });

    return await _getEmojis();
  }

  Future<void> search({
    String? searchTerm,
  }) async {
    if (_debounceTimer != null) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 400), () async {
      final emojis = await _getEmojis(searchTerm: searchTerm);

      state = AsyncValue.data(emojis);
    });
  }

  Future<List<Emoji>> _getEmojis({
    String? searchTerm,
  }) async {
    final emojis = await ref
        .read(emojiRepositoryProvider)
        .getEmojis(searchTerm: searchTerm);

    return emojis;
  }
}
