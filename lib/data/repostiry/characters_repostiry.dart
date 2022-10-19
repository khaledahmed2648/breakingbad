import 'package:breakingbad/data/apis_helper/characters_apis_helper.dart';
import 'package:breakingbad/data/models/characters_model.dart';
import 'package:breakingbad/data/models/quates_model.dart';
import 'package:flutter/cupertino.dart';

class CharactersRepostiry{
 final CharactersApisHelper charactersApisHelper;

  CharactersRepostiry(this.charactersApisHelper);

 Future<List<Character>> getAllCharacters()async{
  final characters=await charactersApisHelper.getAllCharacters();

  return characters.map((character)=>Character.fromJson(character)).toList();
 }
 // Future<List<Quote>>getAllCharactersQuotes(Character character)async{
 //  final quotes= await charactersApisHelper.getCharactersQuates(charName: character.name);
 //  return quotes.map((quotes) =>Quote.fromJson(quotes) ).toList();
 // }
 Future<List<Quote>> getAllCharactersQuotes(String charName)async{
  final quotes=await charactersApisHelper.getCharactersQuates(charName:charName);
  return quotes.map((quoteMap) =>Quote.fromJson(quoteMap)).toList();

 }
}