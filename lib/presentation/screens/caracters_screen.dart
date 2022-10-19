import 'package:breakingbad/basic_logic/cubit/basic_cubit.dart';
import 'package:breakingbad/constents/mycolors.dart';
import 'package:breakingbad/data/models/quates_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../data/models/characters_model.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Quote> quote;
  late List<Character> searshedCharacters;
  bool isSearshed = false;
  var searshController = TextEditingController();

  Widget buildSearshedField() {
    return TextField(
      controller: searshController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find your character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searshedCharacter) {
        addSearshedFromItemToSearshedList(searshedCharacter);
      },
    );
  }

  void addSearshedFromItemToSearshedList(String searshedCharacter) {
    searshedCharacters = allCharacters
        .where((element) =>
            element.name.toLowerCase().startsWith(searshedCharacter))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharacterCubit>(context).getAllCharacters();

  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, BasicState>(
        builder: (context, state) {
      quote =CharacterCubit.get(context).quotes;
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return buildLoadedListWidgets();
      } else
        return Center(
            child: CircularProgressIndicator(
          color: MyColors.myYellow,
        ));
    });
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: buildCharactersList(),
      ),
    );
  }

  // void startSearshing(){
  //
  //
  //   ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: (){
  //     searshController.clear();
  //     Future.delayed(const Duration(milliseconds: 500), () {
  //     setState(() {
  //       isSearshed=false;
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => CharactersScreen()),
  //               (route) => false);
  //     });
  //   });
  //
  //   }));
  // }
  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1, crossAxisCount: 2,
        ),
        shrinkWrap: true,
        itemCount: searshController.text.isEmpty
            ? allCharacters.length
            : searshedCharacters.length,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CharacterItem(
              character: searshController.text.isEmpty
                  ? allCharacters[index]
                  : searshedCharacters[index],

          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        //leading: isSearshed?BackButton(color: MyColors.myGrey,):Container(),
        title: isSearshed
            ? buildSearshedField()
            : Text(
                'Characters',
                style: TextStyle(color: MyColors.myGrey),
              ),
        actions: [
          if (isSearshed)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                isSearshed = false;
                setState(() {
                  searshController.clear();
                });
              },
            )
          else
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                isSearshed = true;
                setState(() {});
              },
            )
        ],
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,ConnectivityResult connectivity,Widget child){
          final bool connected=connectivity!=ConnectivityResult.none;
          if(connected){
            return  buildBlocWidget();
          }
          else{
            return Center(
              child: Container(
                color: MyColors.myGrey,
                  child:Column(
                    children: [
                      Text(
                        'Check your internet...',
                        style: TextStyle(
                          fontSize: 22,
                          color: MyColors.myWhite
                        ),
                      ),
                      Image.asset('assets/images/offline.png')
                    ],
                  ),
              ),
            );
          }
        },
        child: Center(child: CircularProgressIndicator(),),
      )

    );
  }
}
