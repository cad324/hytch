import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hytch_flutter/widgets/DefaultAppBar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('Profile'),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/women/8.jpg'),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Text(
                  "This is the bio that people see when they view your profile.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              TileItem("Edit profile", Icons.person),
              TileItem("Update payment information", Icons.payment),
              TileItem("Change password", Icons.lock),
              TileItem(
                "Log out",
                Icons.exit_to_app,
                trailing: null,
                color: Color.fromARGB(131, 255, 18, 1),
                action: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      title: Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 11, 64, 190)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(10, 11, 64, 190),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            _signOut();
                            Navigator.pushReplacementNamed(context, '/sign-in');
                          },
                          child: Text("Logout"),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 206, 29, 10)),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell TileItem(
    String label,
    IconData leading, {
    IconData? trailing = Icons.chevron_right,
    Color? color,
    void Function()? action,
    String modalLabel = "Are you sure?",
  }) {
    return InkWell(
      splashColor: Color.fromARGB(255, 226, 226, 226),
      splashFactory: InkRipple.splashFactory,
      onTap: () {
        if (action != null) action();
      },
      child: ListTile(
        leading: Icon(
          leading,
          color: color,
        ),
        title: Text(
          label,
          style: TextStyle(color: color),
        ),
        trailing: Icon(trailing),
      ),
    );
  }
}
