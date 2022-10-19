import 'package:breakingbad/constents/strings.dart';
import 'package:dio/dio.dart';

class CharactersApisHelper{
  late Dio dio;
  CharactersApisHelper(){
    BaseOptions options =BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000,
      receiveDataWhenStatusError: true
    );
    dio=Dio(options);

  }
  Future<List<dynamic>> getAllCharacters()async{
    try{
      Response response = await dio.get('characters');
      return response.data;
    }
    catch(error){
      print(error.toString());
      return [];
    }
  }
  Future<List<dynamic>> getCharactersQuates({required String charName})async{
    Response response=await dio.get('quote',queryParameters: {'author':charName});
    return response.data;
  }
}