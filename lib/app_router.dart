import 'package:breakingbad/constents/strings.dart';
import 'package:breakingbad/data/apis_helper/characters_apis_helper.dart';
import 'package:breakingbad/data/models/characters_model.dart';
import 'package:breakingbad/data/models/quates_model.dart';
import 'package:breakingbad/data/repostiry/characters_repostiry.dart';
import 'package:breakingbad/presentation/screens/characters_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'basic_logic/cubit/basic_cubit.dart';
import 'presentation/screens/caracters_screen.dart';

class AppRouter {
  late CharactersRepostiry charactersRepostiry;
  late CharacterCubit characterCubit;

  AppRouter() {
    charactersRepostiry = CharactersRepostiry(CharactersApisHelper());
    characterCubit = CharacterCubit(charactersRepostiry);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (BuildContext context) => characterCubit,
                  child: CharactersScreen(),
                ));

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) =>  CharacterCubit(charactersRepostiry),
              child: CharacterDetailsScreen(character: character),
            ));
    }
  }
}
