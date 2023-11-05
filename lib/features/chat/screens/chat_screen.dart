import 'package:econexus/common/drawer_file.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants/utils.dart';
import '../../authentication/screens/log_in/sign_in_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

//time to work on drawer_file.dart

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
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _firestore.collection('messages').add({
          'text': text,
          'senderId': user.uid,
          'senderEmail': user.email,
          'timestamp': FieldValue.serverTimestamp(),
        });
        _textController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          FirebaseAuth.instance.currentUser != null
              ? Text(
                  'Logged in as: ${FirebaseAuth.instance.currentUser!.email ?? ''}')
              : ElevatedButton(
                  child: Text('Log in'),
                  onPressed: () {
                    moveScreen(context, SignInScreen(), false,
                        isPushReplacement: false);
                  },
                ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return CircularProgressIndicator();
                }
                final messages = snapshot.data!.docs.reversed;
                _messages.clear();
                for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['senderId'];
                  final messageSenderEmail = message.data()['senderEmail'];
                  final currentUser = FirebaseAuth.instance.currentUser;

                  if (messageText != null &&
                      messageSender != null &&
                      messageSenderEmail != null) {
                    final messageWidget = ChatMessage(
                      text: messageText,
                      isMe: currentUser != null &&
                          currentUser.uid == messageSender,
                      senderEmail: messageSenderEmail,
                    );
                    _messages.add(messageWidget);
                  }
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

//fixed null value problem, this should work now

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final String senderEmail;

  ChatMessage(
      {required this.text, required this.isMe, required this.senderEmail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            senderEmail,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
