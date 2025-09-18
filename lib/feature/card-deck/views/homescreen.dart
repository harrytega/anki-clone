import 'package:anki_clone/feature/card-deck/providers/deck_provider.dart';
import 'package:anki_clone/routing/router.dart';
import 'package:anki_clone/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:anki_clone/deck_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Homescreen extends HookConsumerWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createDeckController = useTextEditingController();
    final deckRepo = DeckRepository();

    return Scaffold(
      backgroundColor: AppColors.bggreenish,
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: const Text(
            'KLON',
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 32),
          ),
        ),
        backgroundColor: AppColors.bggreenish,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            SizedBox(
              height: 170,
              width: double.infinity,
              child: GestureDetector(
                onTap: () => context.go('/cards'),
                child: Card(
                  color: AppColors.cardDeckBG,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.web_stories, color: AppColors.white),
                      Gap(8),
                      Text(
                        'Cards',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(16),
            SizedBox(
              height: 170,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  context.go('/decks');
                },
                child: Card(
                  color: AppColors.deckCardBG,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.web_stories, color: Colors.white),
                      Gap(8),
                      Text(
                        'Decks',
                        style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Fab(createDeckController: createDeckController, deckRepo: deckRepo),
    );
  }
}

class Fab extends HookConsumerWidget {
  const Fab({super.key, required this.createDeckController, required this.deckRepo});

  final TextEditingController createDeckController;
  final DeckRepository deckRepo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.lightSalbei,
          title: const Text('Create Deck', style: TextStyle(fontWeight: FontWeight.w600)),
          content: TextField(
            controller: createDeckController,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.cardDeckBG),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'deck name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                createDeckController.clear();
                context.pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () async {
                await deckRepo.createDeck(createDeckController.text);
                ref.invalidate(allDecksProvider);
                createDeckController.clear();
                context.pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: AppColors.black, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(50)),
      backgroundColor: AppColors.fabBG,
      child: Icon(Icons.add, color: AppColors.white),
    );
  }
}
