import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hytch_flutter/screens/AddCard.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardPaymentIcons {
  static Map<String, IconData> brands = {
    'Visa': FontAwesomeIcons.ccVisa,
    'MasterCard': FontAwesomeIcons.ccMastercard,
    'Amex': FontAwesomeIcons.ccAmex,
    'Discover': FontAwesomeIcons.ccDiscover,
    'Diners': FontAwesomeIcons.ccDinersClub,
    'jcb': FontAwesomeIcons.ccJcb,
    'Paypal': FontAwesomeIcons.paypal,
    'ApplePay': FontAwesomeIcons.applePay,
    'GooglePay': FontAwesomeIcons.googlePay,
  };
}

class UpdatePaymentScreen extends StatefulWidget {
  const UpdatePaymentScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePaymentScreen> createState() => _UpdatePaymentScreenState();
}

class _UpdatePaymentScreenState extends State<UpdatePaymentScreen> {
  @override
  void initState() {
    super.initState();
    // _loadPaymentMethods();
  }

  Future<Column> _loadPaymentMethods() async {
    List _data = [];
    var response = await http.get(Uri.http(
      Global.strings['base_endpoint']!,
      '/v1/card',
      {'uid': FirebaseAuth.instance.currentUser!.uid},
    ));
    _data = json.decode(response.body);
    return new Column(
      children: _data.map((item) {
        return new Card(
          child: new ListTile(
            leading: new Icon(CardPaymentIcons.brands[item['card']['brand']]),
            title: new Text(item['card']['last4']),
            subtitle: new Text(item['card']['exp_month'].toString() +
                '/' +
                item['card']['exp_year'].toString()),
            trailing: new IconButton(
              icon: new Icon(Icons.delete),
              onPressed: () async {
                // var response = await http.delete(Uri.http(
                //   Global.strings['base_endpoint']!,
                //   '/v1/card',
                //   {
                //     'uid': FirebaseAuth.instance.currentUser!.uid,
                //     'id': item['id']
                //   },
                // ));
                // if (response.statusCode == 200) {
                //   _loadPaymentMethods();
                // }
              },
            ),
          ),
        );
      }).toList(),
    );
    // _data.forEach((payment) {
    //   print('[Payment] ${payment['card']}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                future: _loadPaymentMethods(),
                builder: (context, AsyncSnapshot<Column> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data ?? Container();
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}",
                        style: TextStyle(color: Colors.red));
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
            InkWell(
              splashColor: Theme.of(context).primaryColor.withAlpha(10),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCardScreen()),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.add,
                  size: 28,
                ),
                title: Text('Add new card'),
                trailing: Icon(Icons.chevron_right, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
