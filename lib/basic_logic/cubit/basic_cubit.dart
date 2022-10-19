import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters_model.dart';
import '../../data/models/quates_model.dart';
import '../../data/repostiry/characters_repostiry.dart';

part 'basic_state.dart';

class CharacterCubit extends Cubit<BasicState> {
  final CharactersRepostiry charactersRepostiry;
  List<Character> character = [];
  List<Quote> quotes = [];

  CharacterCubit(this.charactersRepostiry) : super(BasicInitial());
  static CharacterCubit get(context)=>BlocProvider.of(context);
  List<Character> getAllCharacters() {
    charactersRepostiry.getAllCharacters().then((character) {
      emit(CharactersLoaded(character));
      this.character = character;
    });
    return character;
  }

  List<Quote> getChatacterQuotes(String charName) {
    charactersRepostiry
        .getAllCharactersQuotes(charName)
        .then((value) {
          quotes=value;
          emit(QuotesLoaded(quotes));
    })
        .catchError((error) {});
    return quotes;
  }
}
