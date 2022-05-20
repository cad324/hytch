import 'package:flutter/material.dart';
import 'package:hytch_flutter/widgets/ChatPreview.dart';
import 'package:hytch_flutter/widgets/DefaultAppBar.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('Messages'),
      body: Column(
        children: [
          ChatPreview(
            context,
            'Jamie C.',
            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
            'Hey, we still on?',
            '08:30',
            read: false,
          ),
          ChatPreview(
            context,
            'David G.',
            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
            'Hi there',
            '05:43',
          ),
          ChatPreview(
            context,
            'Robert N.',
            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
            'Ur so good at this',
            'yesterday',
          ),
          ChatPreview(
            context,
            'Margarita T.',
            'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
            'Yeah that works for me',
            'yesterday',
          ),
        ],
      ),
    );
  }
}
