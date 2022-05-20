import 'package:flutter/material.dart';

Widget TripCard(BuildContext context, String name, String avatarImg,
    double rating, int reviewCount, String startLocation, String destination) {
  return Container(
    width: MediaQuery.of(context).size.width - 40,
    height: 225,
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(40, 158, 158, 158),
          blurRadius: 15,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(avatarImg),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        Text(
                          rating.toString() + ' (${reviewCount})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_city,
                        size: 15,
                        color: Theme.of(context).primaryColor.withAlpha(100),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          startLocation,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.more_vert,
                          size: 15,
                          color: Theme.of(context).primaryColor.withAlpha(100)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        size: 15,
                        color: Theme.of(context).primaryColor.withAlpha(100),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          destination,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: OutlinedButton(
            onPressed: () {},
            child: const Text('View Trip'),
            style: OutlinedButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200),
              ),
              primary: Colors.white,
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 94, 94, 94),
                  ),
                ),
                Text(
                  'May 19, 2022',
                  style: TextStyle(
                    color: Color.fromARGB(255, 94, 94, 94),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: Theme.of(context).primaryColor.withAlpha(25),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
