// import 'package:anki_clone/feature/card-deck/views/all_cards_screen.dart';
// import 'package:anki_clone/feature/card-deck/views/all_decks_screen.dart';
// import 'package:anki_clone/feature/card-deck/views/homescreen.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';

// part 'router.g.dart';

// @TypedGoRoute<HomescreenRoute>(
//   path: '/',
//   routes: [
//     TypedGoRoute<AllDecksRoute>(path: 'decks'),
//     TypedGoRoute<AllCardsRoute>(path: 'cards'),
//   ],
// )
// class HomescreenRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return Homescreen();
//   }
// }

// class AllDecksRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return AllDecksScreen();
//   }
// }

// class AllCardsRoute extends GoRouteData {
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return AllCardsScreen();
//   }
// }

// final appRouter = GoRouter(routes: $appRoutes);

import 'package:anki_clone/feature/card-deck/views/all_cards_screen.dart';
import 'package:anki_clone/feature/card-deck/views/all_decks_screen.dart';
import 'package:anki_clone/feature/card-deck/views/homescreen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Homescreen(),
      routes: [
        GoRoute(
          path: 'cards',
          builder: (context, state) => AllCardsScreen(),
        ),
          GoRoute(
          path: 'decks',
          builder: (context, state) => AllDecksScreen(),
        ),
      ]
    )
  ]
);