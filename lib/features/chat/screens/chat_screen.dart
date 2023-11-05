import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/drawer_file.dart';
import '../../../constants/constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _textController = TextEditingController();

  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': text,
        'senderId': FirebaseAuth.instance.currentUser?.uid ?? '',
        'timestamp': FieldValue.serverTimestamp(),
      });
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('$appName'),
        actions: <Widget>[
          FirebaseAuth.instance.currentUser != null
              ? IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                )
              : Container()
        ],
      ),
      body: Column(
        children: <Widget>[
          FirebaseAuth.instance.currentUser != null
              ? Text(
                  'Logged in as: ${FirebaseAuth.instance.currentUser!.email}')
              : ElevatedButton(
                  child: Text('Log in '),
                  onPressed: () {
                    // Implement Google Sign-In here
                  },
                ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final messages = snapshot.data!.docs.reversed;
                _messages.clear();
                for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['senderId'];
                  final currentUser = FirebaseAuth.instance.currentUser;

                  final messageWidget = ChatMessage(
                    text: messageText,
                    isMe: currentUser == messageSender,
                  );
                  _messages.add(messageWidget);
                }
                return ListView(
                  reverse: true,
                  children: _messages,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: (text) {
                      // Handle text input
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_textController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  ChatMessage({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
