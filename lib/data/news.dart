import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/categoriesmodel.dart';
import 'package:newsapp/model/news.dart';

class NewsData {
  Future<NewsChannelHeadlines> fetchNewsChannelsHeadlines(
      {required String id}) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$id&apiKey=f944ae2cf5cf445daeaeb303d7ea9c18';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsChannelHeadlines.fromJson(body);
    }
    throw Exception('Error fetching News');
  }

  Future<NewsCategoriesModel> fetchNewsCategories(
      {required String category}) async {
    String url =
        'https://newsapi.org/v2/top-headlines?q=$category&apiKey=f944ae2cf5cf445daeaeb303d7ea9c18';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsCategoriesModel.fromJson(body);
    }
    throw Exception('Error fetching News');
  }
}
