import 'package:fb_app/Model/message.dart';
import 'package:fb_app/constant/constant.dart';
import 'package:fb_app/widgets/chat_bubbel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  static String id = 'chatPage';
  final _controller = ScrollController();

  CollectionReference message_reference =
      FirebaseFirestore.instance.collection(kMessageCollection);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: message_reference
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        //define the list to store message form firebase
        List<Message> messageList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          messageList.add(Message.fromJson(snapshot.data!.docs[i]));
        }
        if (snapshot.hasData) {
          //print(snapshot.data!.docs[0]['message']);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/login.jpeg',
                      height: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Chat App')
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(message: messageList[index])
                            : ChatBubble(message: messageList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      message_reference.add({
                        kMessage: data,
                        'createdAt': DateTime.now(),
                        'id': email
                      });
                      _controller.animateTo(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn);
                      controller.clear();
                    },
                    decoration: InputDecoration(
                      hintText: 'Send a message..',
                      suffixIcon: const Icon(Icons.send),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('is Loading');
        }
      },
    );
  }
}
