import 'package:flutter/material.dart';
import 'package:grad_project/core/colors.dart';
import 'package:grad_project/screens/chatbot/chatbot.dart';

class ChatBotton extends StatelessWidget {
  const ChatBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset("assets/images/chat_image.png"),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => Chatbot()));
        },
      ),
    );
  }
}
