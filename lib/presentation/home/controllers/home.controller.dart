import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:popularmemes/model/meme.dart';


class HomeController extends GetxController {
  
  var memeList = <Meme>[].obs;
  var searchMemes = <Meme>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchMemes();
  }

  Future<void> fetchMemes() async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('https://api.imgflip.com/get_memes'));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var memes = jsonResponse['data']['memes'] as List;
        memeList.value = memes.map((json) => Meme.fromJson(json)).toList();
        searchMemes.value = memeList; 
      } else {
        errorMessage('Failed to load memes');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchMeme(String query) {
    if (query.isEmpty) {
      searchMemes.value = memeList; 
    } else {
      searchMemes.value = memeList
          .where(
              (meme) => meme.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
