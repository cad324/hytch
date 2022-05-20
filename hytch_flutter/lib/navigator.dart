import 'package:flutter/material.dart';
import 'package:hytch_flutter/screens/Home.dart';
import 'package:hytch_flutter/screens/Messages.dart';
import 'package:hytch_flutter/screens/Profile.dart';
import 'package:hytch_flutter/screens/Search.dart';
import 'package:badges/badges.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  int pageIndex = 0;

  final pages = [
    HomePage(), // 0
    SearchPage(), // 1
    MessagesPage(), // 2
    ProfilePage(), // 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          height: 75,
          padding: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(46, 157, 30, 226), blurRadius: 25),
            ],
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: Icon(Icons.home,
                  color: Theme.of(context)
                      .primaryColor
                      .withAlpha(pageIndex == 0 ? 200 : 150),
                  size: pageIndex == 0 ? 28 : 24),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: Icon(Icons.search_rounded,
                  color: Theme.of(context)
                      .primaryColor
                      .withAlpha(pageIndex == 1 ? 200 : 150),
                  size: pageIndex == 1 ? 28 : 24),
            ),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: Badge(
                  badgeContent: Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                  badgeColor: Color.fromARGB(255, 205, 21, 21),
                  child: Icon(Icons.chat_bubble_rounded,
                      color: Theme.of(context)
                          .primaryColor
                          .withAlpha(pageIndex == 2 ? 200 : 150),
                      size: pageIndex == 2 ? 28 : 24),
                )),
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: Icon(Icons.person,
                    color: Theme.of(context)
                        .primaryColor
                        .withAlpha(pageIndex == 3 ? 200 : 150),
                    size: pageIndex == 3 ? 28 : 24)),
          ]),
        ));
  }
}
