// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/model/newsviewmodel.dart';
import 'package:newsapp/screens/details.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final categories = [
    'General',
    'Sports',
    'Health',
    'Business',
    'Science',
    'Technology',
    'Entertainment',
  ];
  String name = 'General';

  NewsViewModel data = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * .07,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: const WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        backgroundColor: WidgetStatePropertyAll(
                            name == categories[index]
                                ? Colors.blueGrey.shade700
                                : Colors.grey),
                      ),
                      onPressed: () {
                        setState(() {
                          name = categories[index];
                        });
                      },
                      child: Text(
                        categories[index],
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Times New Roman'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: data.fetchNewsCategories(
                id: name,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      color: Colors.blueGrey.shade900,
                      size: 100,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    final date = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString());
                    final format = DateFormat('MMMM dd, yyyy');
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              final date = DateTime.parse(snapshot
                                  .data!.articles![index].publishedAt
                                  .toString());
                              final format = DateFormat('MMMM dd, yyyy');
                              final newdate = format.format(date);
                              return FadeTransition(
                                opacity: animation,
                                child: DetailsScreen(
                                  description: snapshot
                                      .data!.articles![index].description
                                      .toString(),
                                  imageurl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  title: snapshot.data!.articles![index].title
                                      .toString(),
                                  url: snapshot.data!.articles![index].url
                                      .toString(),
                                  date: newdate,
                                  source: snapshot
                                      .data!.articles![index].source!.name
                                      .toString(),
                                ),
                              );
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(seconds: 1),
                            reverseTransitionDuration:
                                const Duration(seconds: 1),
                          ));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontFamily: 'Times New Roman'),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Times New Roman'),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        format.format(date),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                            fontFamily: 'Times New Roman'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
