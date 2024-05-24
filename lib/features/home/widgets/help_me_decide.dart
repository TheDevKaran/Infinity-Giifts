import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:lastminutegift/constants/gloVar.dart';

class HelpMeDecide extends StatefulWidget {
  static const String routeName = '/help-me-decide';
  const HelpMeDecide({super.key});

  @override
  State<HelpMeDecide> createState() => _HelpMeDecideState();
}

class _HelpMeDecideState extends State<HelpMeDecide> {
  TextEditingController _userInput = TextEditingController();
  static const apiKey = "<Enter Gemini Key>";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<Message> _messages = [];
  bool _isTyping = false;
  bool _isSending = false; // To track if user is sending a message
  String? _contextMessage; // Variable to store the context message

  @override
  void initState() {
    super.initState();
    _initiateConversation();
  }

  Future<void> _initiateConversation() async {
    setState(() {
      _isTyping = true; // Show "Gemini is typing"
    });

    final contextMessage = "You are a helpful assistant for a gift store. Suggest gift ideas based on the user's query. Give a sample conversation message at the start. Tell them to be desrciptive and describe whom you want to gift, what is their age, what is their relation with you, what is your budget, by when do you want to gift, what do they love. And remember your name is infinity. so address yourself as infinity. while giving prompts, address yourselves as infinty and not assistant";

    final response = await model.generateContent([Content.text(contextMessage)]);

    setState(() {
      _messages.add(Message(isUser: false, message: response.text ?? "", date: DateTime.now()));
      _isTyping = false; // Hide "Gemini is typing"
      _contextMessage = response.text; // Set initial context
    });
  }

  Future<void> sendMessage() async {
    final message = _userInput.text.trim(); // Trim message to remove leading/trailing spaces

    if (message.isEmpty) {
      return; // If message is empty, do not send
    }

    setState(() {
      _isSending = true; // Set sending state to true
      _messages.add(Message(isUser: true, message: message, date: DateTime.now()));
      _userInput.clear(); // Clear input field
    });

    // Prepare the content for Gemini, including the context if available
    final content = <Content>[];
    if (_contextMessage != null) {
      content.add(Content.text(_contextMessage!));
    }
    content.addAll([Content.text(message)]);

    setState(() {
      _isTyping = true; // Show "Gemini is typing"
    });

    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(isUser: false, message: response.text ?? "", date: DateTime.now()));
      _isTyping = false; // Hide "Gemini is typing"
      _isSending = false; // Reset sending state
      // Set the context message for the next interaction
      _contextMessage = response.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
          ),
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/logo-no-background.png', width: 120, height: 45, ),
              ),
            ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(text: TextSpan(text:  'Help Me Decide',
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Color.fromRGBO(161, 39, 16, 1)))
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 10),
                        Text('Infinity is typing...', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  );
                }
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('HH:mm').format(message.date),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: TextFormField(
                    enabled: !_isSending, // Disable input field when sending
                    style: TextStyle(color: Colors.black),
                    controller: _userInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Enter Your Message',
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.all(12),
                  iconSize: 30,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),
                  onPressed: _isSending ? null : sendMessage, // Disable button when sending
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? GlobalVariables.selectedNavBarColor : Colors.grey.shade400,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
          topRight: Radius.circular(10),
          bottomRight: isUser ? Radius.zero : Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarkdownBody(
            data: message,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(fontSize: 16, color: isUser ? Colors.white : Colors.black),
              strong: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5,),
          Text(
            date,
            style: TextStyle(fontSize: 10, color: isUser ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}
