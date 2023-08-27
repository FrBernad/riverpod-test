import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtest/features/emojis/application/emojis_search_controller.dart';
import 'package:riverpodtest/features/emojis/presentation/widgets/no_emojis_found.dart';

import 'emoji_card.dart';
import 'error_message.dart';

class EmojisList extends ConsumerWidget {
  const EmojisList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emojiSearchController = ref.watch(emojisSearchControllerProvider);

    return emojiSearchController.when(
      data: (emojis) {
        if (emojis.isEmpty) {
          return const NoEmojisFound();
        } else {
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            itemCount: emojis.length,
            itemBuilder: (context, index) => EmojiCard(
              emoji: emojis[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 24,
            ),
          );
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          const Align(alignment: Alignment.topCenter, child: ErrorMessage()),
    );
  }
}
