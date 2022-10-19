import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad/basic_logic/cubit/basic_cubit.dart';
import 'package:breakingbad/constents/mycolors.dart';
import 'package:breakingbad/data/models/characters_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/apis_helper/characters_apis_helper.dart';
import '../../data/models/quates_model.dart';
import '../../data/repostiry/characters_repostiry.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  Widget characterInfo({
    required String title,
    required String value,
  }) {
    return RichText(
      maxLines: 1,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.myWhite,
                fontSize: 18)),
        TextSpan(
            text: value,
            style: TextStyle(color: MyColors.myWhite, fontSize: 16))
      ]),
    );
  }

  Widget buildDivider({required double endendent}) {
    return Divider(
      height: 30,
      endIndent: endendent,
      thickness: 2,
      color: MyColors.myYellow,
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getChatacterQuotes(character.name);

    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            // pinned: true,
            //stretch: true,
            backgroundColor: MyColors.myGrey,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                character.nick_name,
                style: TextStyle(color: MyColors.myWhite),
              ),
              background: Hero(
                  tag: character.char_id,
                  child: Image.network(
                    '${character.img}',
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  characterInfo(
                      title: 'Jop : ', value: character.jop.join(' / ')),
                  buildDivider(endendent: 285),
                  characterInfo(
                      title: 'Appeard in : ',
                      value: character.categoryForTwoSeries),
                  buildDivider(endendent: 220),
                  characterInfo(
                      title: 'Seasons : ',
                      value: character.appearanceOfSeasons.join(' / ')),
                  buildDivider(endendent: 250),
                  characterInfo(
                      title: 'Status : ', value: character.status_liveOrDead),
                  buildDivider(endendent: 270),
                  if (character.better_call_saul_appearance.isNotEmpty)
                    characterInfo(
                        title: 'Better call sual seasons : ',
                        value:
                            character.better_call_saul_appearance.join(' / ')),
                  if (character.better_call_saul_appearance.isNotEmpty)
                    buildDivider(endendent: 120),
                  characterInfo(
                      title: 'Actor/actress : ', value: character.actorName),
                  buildDivider(endendent: 200),
                  SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<CharacterCubit, BasicState>(
                    builder: (context, state) {

                      print(CharacterCubit.get(context).quotes);

                      if (state is QuotesLoaded) {
                        print(state.quotes);
                        if (state.quotes.isNotEmpty) {
                          int randomQuoteIndex =
                              Random().nextInt(state.quotes.length - 1);
                          return Center(
                            child: DefaultTextStyle(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: MyColors.myWhite,
                                  fontSize: 20,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 7,
                                        color: MyColors.myYellow,
                                        offset: Offset(0, 0))
                                  ]),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  TyperAnimatedText(
                                      state.quotes[randomQuoteIndex].quote)
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColors.myWhite,
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
            )
          ]))
        ],
      ),
    );
  }
}
