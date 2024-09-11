import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final String title;
  final String imageurl;
  final String description;
  final String url;
  final String date;
  final String source;
  const DetailsScreen({
    super.key,
    required this.description,
    required this.imageurl,
    required this.title,
    required this.url,
    required this.date,
    required this.source,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      // appBar: AppBar(
      //   title: const Text(
      //     'Details',
      //     style: TextStyle(
      //         fontSize: 40,
      //         fontWeight: FontWeight.bold,
      //         fontFamily: 'Times New Roman'),
      //   ),
      //   centerTitle: true,
      // ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: widget.imageurl.isNotEmpty
                ? ClipRRect(
                    child: Image.network(
                      widget.imageurl,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SpinKitCircle(
                    color: Colors.grey,
                  ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Card(
              color: const Color.fromARGB(183, 173, 173, 173),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Times New Roman'),
                    ),
                    Text(
                      widget.source,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Times New Roman'),
                    ),
                    Text(
                      widget.date,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Times New Roman'),
                    ),
                    const Text(
                      'Description:',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Times New Roman'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Times New Roman'),
                    ),
                    Center(
                      child: TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blueGrey)),
                          onPressed: readdetails,
                          child: const Text(
                            'More>',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: 'Times New Roman'),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future readdetails() async {
    final url = Uri.parse(widget.url);

    // ignore: deprecated_member_use
    await launchUrl(url, mode: LaunchMode.inAppWebView);
  }
}
