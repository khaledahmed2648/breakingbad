import 'package:breakingbad/constents/mycolors.dart';
import 'package:breakingbad/constents/strings.dart';
import 'package:breakingbad/data/models/quates_model.dart';
import 'package:flutter/material.dart';

import '../../data/models/characters_model.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key,required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, characterDetailsScreen,arguments: character);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(9),
        ),
        child: GridTile(
          child: Hero(
            tag: character.char_id,
            child: Container(
              color: MyColors.myGrey,
                child: character.img.isNotEmpty?
                FadeInImage.assetNetwork(width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/loading.gif',
                    image: character.img
                ): Image.asset('assets/images/question.jpg'),
            ),
          ),
          footer: Container(
            width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${character.name}',
                style: TextStyle(
                  height: 1.3,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                  textAlign: TextAlign.center,
              ),
          ),
        )
      ),
    );
  }
}
