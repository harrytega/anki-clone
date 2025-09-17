import 'package:anki_clone/feature/card-deck/providers/deck_provider.dart';
import 'package:anki_clone/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllDecksScreen extends HookConsumerWidget {
  const AllDecksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final decksAsyncValue = ref.watch(allDecksProvider);
    return Scaffold(
      backgroundColor: AppColors.bggreenish,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        title: const Text('Decks', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
        backgroundColor: AppColors.bggreenish,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Gap(16),
            Expanded(
              child: decksAsyncValue.when(
                data: (decks) {
                  return ListView.builder(
                    itemCount: decks.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 170,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            color: AppColors.deckCardBG,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.web_stories, color: Colors.white),
                                Gap(8),
                                Text(
                                  decks[index].name,
                                  style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) => const Text('Error loading decks'),
                loading: () => const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
