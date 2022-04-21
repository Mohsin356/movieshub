import 'dart:convert';
import 'package:http/http.dart' as http;
class Requests{
  static List data=[];
  static const String imageUrl = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/";
static Future<String> fetchData() async{
var response=  await http.get(Uri.parse('http://api.themoviedb.org/3/movie/top_rated?api_key=e5013e88aad0bad4821bdac93d1d6a30'));
var content = jsonDecode(response.body);
data = content['results'];
return 'success';
}

}