import 'package:anki_clone/deck_repository.dart';
import 'package:anki_clone/feature/card-deck/models/card_deck.dart';
import 'package:anki_clone/feature/card-deck/providers/deck_provider.dart';
import 'package:anki_clone/feature/card-deck/views/homescreen.dart';
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
    final createDeckController = useTextEditingController();
    final deckRepo = DeckRepository();
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50), borderSide: BorderSide.none),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
                filled: true,
                fillColor: AppColors.lightSalbei,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.deckCardBG),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Gap(32),
            Expanded(
              child: decksAsyncValue.when(
                data: (decks) {
                  return ListView.builder(
                    itemCount: decks.length,
                    itemBuilder: (context, index) {
                      return DeckCardWithBottomMargin(id: decks[index].id);
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
      floatingActionButton: Fab(createDeckController: createDeckController, deckRepo: deckRepo),
    );
  }
}

class DeckCardWithBottomMargin extends HookConsumerWidget {
  const DeckCardWithBottomMargin({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckRepo = DeckRepository();
    final deck = deckRepo.getDeckById(id);
    return Column(
      children: [
        SizedBox(
          height: 170,
          width: double.infinity,
          child: InkWell(
            onTap: () {},
            child: Card(
              color: AppColors.deckCardBG,
              child: Stack(
                children: [
                  Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.web_stories, color: Colors.white),
                          Gap(8),
                          FutureBuilder(
                            future: deckRepo.getDeckById(id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const SizedBox(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError || !snapshot.hasData) {
                                return Text('Error: no deck');
                              }
                              final deck = snapshot.data!;
                              return Text(
                                deck.name,
                                style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w700),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: IconButton(
                      onPressed: () async {
                        await deckRepo.deleteDeck(id);
                        ref.invalidate(allDecksProvider);
                      },
                      icon: Icon(Icons.delete, color: AppColors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 36,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(16),
      ],
    );
  }
}
