part of 'basic_cubit.dart';

@immutable
abstract class BasicState {}

class BasicInitial extends BasicState {}
class CharactersLoaded extends BasicState{
  final List<Character> characters;

  CharactersLoaded(this.characters);
}
class QuotesLoaded extends BasicState{
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}
