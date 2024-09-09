import 'package:newsapp/data/news.dart';
import 'package:newsapp/model/categoriesmodel.dart';
import 'package:newsapp/model/news.dart';

class NewsViewModel {
  final repo = NewsData();
  Future<NewsChannelHeadlines> fetchHeadlines({required String id}) async {
    final response = await repo.fetchNewsChannelsHeadlines(id: id);

    return response;
  }

  Future<NewsCategoriesModel> fetchNewsCategories({required String id}) async {
    final response = await repo.fetchNewsCategories(category: id);

    return response;
  }
}
