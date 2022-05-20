import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hytch_flutter/widgets/TripCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DashboardAppBar(),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trips',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          icon: Icon(Icons.filter_list),
                          onPressed: () {},
                          splashColor:
                              Theme.of(context).primaryColor.withAlpha(5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TripCard(
                    context,
                    'Yupawadee G.',
                    'https://randomuser.me/api/portraits/women/8.jpg',
                    4.75,
                    104,
                    '54 Queen St, Fredericton, NB E3B 0C6',
                    '104 Lemon Dr, Halifax, NS B3K 2N2',
                  ),
                  TripCard(
                    context,
                    'Giani F.',
                    'https://randomuser.me/api/portraits/men/5.jpg',
                    2.75,
                    13,
                    '444 Constant Rd. Saint John, NB E4B 7X8',
                    '34 Oromocto St, Moncton, NB A3J 2H2',
                  ),
                  TripCard(
                    context,
                    'Jordyn W.',
                    'https://randomuser.me/api/portraits/women/3.jpg',
                    4.44,
                    104,
                    '54 Queen St, Fredericton, NB E3B 0C6',
                    '104 Lemon Dr, Halifax, NS B3K 2N2',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 75, left: 20, right: 20),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color.fromARGB(255, 132, 37, 205),
              Color.fromARGB(255, 178, 65, 196)
            ],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Welcome back,\n${FirebaseAuth.instance.currentUser!.displayName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white.withAlpha(15),
                ),
                child: IconButton(
                  onPressed: () {},
                  color: Colors.white,
                  iconSize: 24,
                  icon: Badge(
                    badgeContent: Text(
                      '99+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                    badgeColor: Colors.red,
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 25,
                      color: Theme.of(context).primaryColor.withAlpha(50)),
                ]),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    isDense: true,
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 24,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Where do you want to go?',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
