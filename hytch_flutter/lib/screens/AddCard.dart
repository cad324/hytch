import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:hytch_flutter/main.dart';
import 'package:http/http.dart' as http;

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  String _cardHolder = '';
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvvCode = '';
  bool _isCvvFocused = false;
  bool _validCard = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreditCardValidator _validator = CreditCardValidator();
  bool _isValidCard() {
    var validNum = _validator.validateCCNum(_cardNumber);
    var validExp = _validator.validateExpDate(_expiryDate);
    var validCvv = _validator.validateCVV(_cvvCode, validNum.ccType);
    return validNum.isValid &&
        validExp.isValid &&
        validCvv.isValid &&
        _cardHolder.isNotEmpty;
  }

  String? base_uri = Global.strings['base_endpoint'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Card',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                CreditCardWidget(
                  onCreditCardWidgetChange: (card) {},
                  cardNumber: _cardNumber,
                  expiryDate: _expiryDate,
                  cardHolderName: _cardHolder,
                  cvvCode: _cvvCode,
                  cardBgColor: Theme.of(context).primaryColor,
                  showBackView: _isCvvFocused,
                  isHolderNameVisible: true,
                ),
                CreditCardForm(
                  formKey: _formKey,
                  onCreditCardModelChange: (CreditCardModel data) {
                    setState(() {
                      _cardHolder = data.cardHolderName;
                      _cardNumber = data.cardNumber;
                      _expiryDate = data.expiryDate;
                      _cvvCode = data.cvvCode;
                      _isCvvFocused = data.isCvvFocused;
                      _validCard = _isValidCard();
                    });
                  },
                  themeColor: Colors.red,
                  obscureCvv: true,
                  expiryDate: '',
                  obscureNumber: true,
                  cardHolderName: '',
                  cardNumber: '',
                  cvvCode: '',
                  isHolderNameVisible: true,
                  isCardNumberVisible: true,
                  isExpiryDateVisible: true,
                  cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'MM/YY',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(250),
                      boxShadow: _validCard
                          ? [
                              BoxShadow(
                                blurRadius: 20,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.25),
                              )
                            ]
                          : [],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: _validCard
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      onPressed: _validCard
                          ? () async {
                              try {
                                var response = await http.post(
                                  Uri.http(base_uri!, '/v1/card'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode({
                                    'uuid':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'card_number': _cardNumber,
                                    'exp_date': _expiryDate,
                                    'cvv': _cvvCode,
                                    'card_holder': _cardHolder,
                                  }),
                                );
                                if (response.statusCode == 200) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
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
                                          'New card added!',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    dismissDirection: DismissDirection.vertical,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Something went wrong!',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    dismissDirection: DismissDirection.vertical,
                                  ));
                                }
                              } catch (e) {
                                print('[Save card]: $e');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        'Something went wrong! Please try again.',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  dismissDirection: DismissDirection.vertical,
                                ));
                              }
                            }
                          : null,
                      child: Text('Save card'),
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
