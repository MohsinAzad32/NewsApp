import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/screens/details.dart';
// import 'package:intl/intl.dart';
import 'package:newsapp/model/newsviewmodel.dart';
import 'package:newsapp/screens/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Filterlist {
  bbcNews,

  alJazeera,
  reuters,
  cnn,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel data = NewsViewModel();
  Filterlist? selectedmenu;
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: const CategoriesScreen(),
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              transitionDuration: const Duration(seconds: 1),
              reverseTransitionDuration: const Duration(seconds: 1),
            ));
          },
          icon: const Icon(Icons.menu),
        ),
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              initialValue: selectedmenu,
              onSelected: (Filterlist item) {
                if (Filterlist.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }

                if (Filterlist.alJazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }
                if (Filterlist.reuters.name == item.name) {
                  name = 'reuters';
                }
                if (Filterlist.cnn.name == item.name) {
                  name = 'cnn';
                }

                setState(() {
                  selectedmenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<Filterlist>>[
                    const PopupMenuItem<Filterlist>(
                      value: Filterlist.bbcNews,
                      child: Text(
                        'BBC News',
                      ),
                    ),
                    const PopupMenuItem<Filterlist>(
                      value: Filterlist.alJazeera,
                      child: Text('Al-Jazeera'),
                    ),
                    const PopupMenuItem<Filterlist>(
                      value: Filterlist.reuters,
                      child: Text('reuters'),
                    ),
                    const PopupMenuItem<Filterlist>(
                      value: Filterlist.cnn,
                      child: Text('cnn'),
                    ),
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: FutureBuilder(
                future: data.fetchHeadlines(id: name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.blueGrey.shade900,
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        final date = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        final format = DateFormat('MMMM dd, yyyy');
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .6,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  // height: MediaQuery.of(context).size.height * 0.9,
                                  // width: MediaQuery.of(context).size.width * 0.8,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      snapshot.data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        pageBuilder: (ctx, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: DetailsScreen(
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              imageurl: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              title: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              url: snapshot
                                                  .data!.articles![index].url
                                                  .toString(),
                                              date: format.format(date),
                                              source: snapshot.data!
                                                  .articles![index].source!.name
                                                  .toString()),
                                        ),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(seconds: 1),
                                        reverseTransitionDuration:
                                            const Duration(seconds: 1),
                                      ));
                                    },
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily:
                                                      'Times New Roman'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Times New Roman'),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                format.format(date),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Times New Roman'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        );
                      },
                    );
                  }
                  return Container();
                },
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: FutureBuilder(
              future: data.fetchNewsCategories(id: 'general'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitCircle(
                    color: Colors.blueGrey.shade900,
                    size: 100,
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      final date = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());
                      final format = DateFormat('MMMM dd, yyyy');
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              final item = snapshot.data!.articles![index];
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: DetailsScreen(
                                          description: item.content.toString(),
                                          imageurl: item.urlToImage.toString(),
                                          title: item.title.toString(),
                                          url: item.url.toString(),
                                          date: item.publishedAt.toString(),
                                          source: item.source!.name.toString()),
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(seconds: 1),
                                  reverseTransitionDuration:
                                      const Duration(seconds: 1),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: ListTile(
                              // leading: SizedBox(
                              //   height: MediaQuery.of(context).size.height * 0.2,
                              //   width: MediaQuery.of(context).size.width * 0.3,
                              //   child: ClipRRect(
                              //     child: Image.network(
                              //       snapshot.data!.articles![index].urlToImage
                              //           .toString(),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
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
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Times New Roman'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
