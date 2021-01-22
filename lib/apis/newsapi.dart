import 'dart:convert';

import 'package:get_api_0/models/articles_models.dart';
import 'package:get_api_0/strings/urls.dart';
import 'package:http/http.dart';

class NewsApi {
  var newsApi;
  Future<NewsModel> getNews() async {
    try {
      Response response = await get(Strings.newsApiUrl);
      if (response.statusCode == 200) {
        var jsonStringApi = response.body;
        var jsonApi = json.decode(jsonStringApi);
        newsApi = NewsModel.fromJson(jsonApi);
      }
    } catch (e) {
      print(e.toString());
    }
    return newsApi;
  }
}

class NewsApiCategory {
  var newsApiCategory;
  Future<NewsModel> getNewsCategory(String category) async {
    String newsAipUrlCategory =
        "https://newsapi.org/v2/top-headlines?category=$category& =country=us&apiKey=30c59e78e3b34caa92f2367af40f4f24";
    try {
      Response response = await get(newsAipUrlCategory);
      if (response.statusCode == 200) {
        var jsonStringApi = response.body;
        var jsonApi = json.decode(jsonStringApi);
        newsApiCategory = NewsModel.fromJson(jsonApi);
      }
    } catch (e) {
      print(e.toString());
    }
    return newsApiCategory;
  }
}
