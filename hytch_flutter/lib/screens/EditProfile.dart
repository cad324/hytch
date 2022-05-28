import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Stack(
          children: [
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(250),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.25),
                        )
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Profile updated!',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          dismissDirection: DismissDirection.vertical,
                        ));
                      },
                      child: Text('Save changes'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
