import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:vativeapp_chatapp_firebase/pages/auth/login_page.dart';
import 'package:vativeapp_chatapp_firebase/pages/home_page.dart';
import 'package:vativeapp_chatapp_firebase/pages/news_container.dart';
import 'package:vativeapp_chatapp_firebase/service/auth_service.dart';
import 'package:vativeapp_chatapp_firebase/widgets/widgets.dart';

class NewsScreenPage extends StatefulWidget {
  String userName;
  String email;
//  NewsScreenPage({super.key});
  NewsScreenPage({Key? key, required this.email, required this.userName})
      : super(key: key);

  @override
  State<NewsScreenPage> createState() => _NewsScreenPageState();
}

class _NewsScreenPageState extends State<NewsScreenPage> {
  List<dynamic> tournamentList = [];
  bool isLoading = true;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://newsapi.org/v2/everything?apiKey=b5fabe4c8dd44cfc839430e4612176fd&domains=wsj.com'));

    http.StreamedResponse response = await request.send();
    print("response news api");
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      setState(() {
        tournamentList = json.decode(data)['articles'];
        print('data');
        print(tournamentList);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load response news api');
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: const Text(
            "News Screen",
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
            child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreen(context, const HomePage());
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {},
              selected: true,
              selectedColor: Theme.of(context).primaryColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    NewsScreenPage(
                      userName: widget.userName,
                      email: widget.email,
                    ));
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.newspaper),
              title: const Text(
                "News",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        )),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tournamentList.length,
                    itemBuilder: (context, index) {
                      return NewsDetails(
                        title: tournamentList[index]['title'].toString(),
                        urlToImage:
                            tournamentList[index]['urlToImage'].toString(),
                        author: tournamentList[index]['author'].toString(),
                        description:
                            tournamentList[index]['description'].toString(),
                        publishedAt:
                            // tournamentList[index]['description'].toString(),
                            DateTime.parse(tournamentList[index]['publishedAt'])
                                    .toString()
                                    .substring(5, 10) +
                                "-" +
                                DateTime.parse(
                                        tournamentList[index]['publishedAt'])
                                    .toString()
                                    .substring(0, 4),
                        content: tournamentList[index]['content'].toString(),
                      );
                    },
                  ),
                ),
        ));
  }
}
