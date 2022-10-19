class Character{
  late int char_id;
  late String name;
  late String nick_name;
  late String birthday;
  late List<dynamic> jop;
  late String img;
  late String status_liveOrDead;
  late List<dynamic> appearanceOfSeasons;
  late String actorName;
  late String categoryForTwoSeries;
  late List<dynamic> better_call_saul_appearance;

  Character.fromJson(Map<String,dynamic>json){
    char_id=json['char_id'];
    name=json['name'];
    nick_name=json['nickname'];
    birthday=json['birthday'];
    jop=json['occupation'];
    img=json['img'];
    status_liveOrDead=json['status'];
    appearanceOfSeasons=json['appearance'];
    actorName=json['portrayed'];
    categoryForTwoSeries=json['category'];
    better_call_saul_appearance=json['better_call_saul_appearance'];
  }

}