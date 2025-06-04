import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "User",
    profileImage: "assets/images/3bwhab2.jpg",
  );
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage: "assets/images/chat_image.png",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        leadingWidth: 30,
        backgroundColor: Color(0xff407CE2),
        title: Row(
          children: [
            ClipOval(
              child: Image.asset("assets/images/chat_image.png", width: 30),
            ),
            Gap(10),
            Text(
              "ChatBot",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(children: [Expanded(child: _buildUI())]),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      inputOptions: InputOptions(
        alwaysShowSend: true,
        inputDecoration: InputDecoration(
          hintText: "Write your message ...",
          filled: true,
          fillColor: Color(0xFFD8D8D8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
        sendButtonBuilder: (onSend) {
          return GestureDetector(
            onTap: onSend,
            child: Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff407CE2),
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.send, color: Colors.white, size: 25),
              ),
            ),
          );
        },
      ),
      messageOptions: const MessageOptions(
        showTime: true,
        showCurrentUserAvatar: true,
        containerColor: Color(0xff407CE2),
        currentUserContainerColor: Color(0xFFCECDCD),
        textColor: Colors.white,
        currentUserTextColor: Colors.black,
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;

      gemini.streamGenerateContent(question).listen((event) {
        String response =
            event.content?.parts
                ?.whereType<TextPart>()
                .map((part) => part.text.trim())
                .join(" ")
                .replaceAll(RegExp(r'\s+'), ' ')
                .trim() ??
            "";

        response = _cleanMarkdown(response);

        if (response.isEmpty) return;

        if (messages.isNotEmpty && messages.first.user == geminiUser) {
          ChatMessage lastMessage = messages.removeAt(0);
          lastMessage = ChatMessage(
            user: geminiUser,
            createdAt: lastMessage.createdAt,
            text: lastMessage.text + " " + response,
          );
          setState(() {
            messages = [lastMessage, ...messages];
          });
        } else {
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  String _cleanMarkdown(String text) {
    return text
        .replaceAll(RegExp(r'\*{1,2}'), '')
        .replaceAll(RegExp(r'`'), '')
        .replaceAll(RegExp(r'_'), '')
        .replaceAll(RegExp(r'\#'), '')
        .replaceAll(RegExp(r'>'), '')
        .replaceAll(RegExp(r'-'), '')
        .trim();
  }
}