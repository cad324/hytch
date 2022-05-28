import 'package:flutter/material.dart';

const DUMMY_CHAT = [];

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jamie C.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Messages'),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
            ),
            margin: EdgeInsets.only(bottom: 50),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Type a message...',
              ),
            ),
          )
        ],
      ),
    );
  }
}
