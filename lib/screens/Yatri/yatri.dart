import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Yatri extends StatefulWidget {
  const Yatri({Key? key}) : super(key: key);

  @override
  _YatriState createState() => _YatriState();
}

class _YatriState extends State<Yatri> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();
    const apiKey =
        'AIzaSyBH5NYRQ0AyKg43_BJ4FT-qUjq85ZSuXFc'; // Replace with your actual API key
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 500),
    );
    _chat = _model.startChat(history: [
      Content.text(
          'Hi, I am Yatri, your travel assistant. How can I help you today?'),
      Content.model([
        TextPart(
            "YatraZen's own AI yatri is Based on Gemini Pro & here to help you with your travel queries")
      ])
    ]);
  }

  Future<void> sendMessage(String? text) async {
    if (text != null && text.isNotEmpty) {
      try {
        var content = Content.text(text);
        var response = await _chat.sendMessage(content);
        setState(() {
          _messages.add(ChatMessage(text: text, isUser: true));
          _messages.add(ChatMessage(text: response.text ?? "", isUser: false));
        });
        _controller.clear();
      } catch (error) {
        // Handle error here, e.g., display an error message to the user
        print('Error sending message: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yatri AI",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: _messages[index]);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => sendMessage(_controller.text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: message.isUser ? Colors.blue : Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: message.isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!message.isUser) ...[
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/bot_image.png'),
                  radius: 20,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: message.isMarkdown
                    ? MarkdownBody(
                        data: message.text,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(color: Colors.white),
                        ),
                      )
                    : Text(
                        message.text,
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
              if (message.isUser) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/user_image.png'),
                  radius: 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isMarkdown;

  const ChatMessage(
      {required this.text, required this.isUser, this.isMarkdown = false});
}
