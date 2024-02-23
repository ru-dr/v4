import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Yatri extends StatefulWidget {
  const Yatri({Key? key}) : super(key: key);

  @override
  _YatriState createState() => _YatriState();
}

class _YatriState extends State<Yatri> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  late final GenerativeModel _model;
  late final ChatSession _chat;

  @override
  void initState() {
    super.initState();
    const apiKey = 'AIzaSyBH5NYRQ0AyKg43_BJ4FT-qUjq85ZSuXFc'; // Replace with your actual API key
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
      generationConfig: GenerationConfig(maxOutputTokens: 100),
    );
    _chat = _model.startChat(history: [
      Content.text('Hello, I have 2 dogs in my house.'),
      Content.model([TextPart('Great to meet you. What would you like to know?')])
    ]);
  }

  Future<void> sendMessage(String text) async {
    try {
      var content = Content.text(text);
      var response = await _chat.sendMessage(content);
      setState(() {
        _messages.add('User: $text');
        _messages.add('Bot: ${response.text}');
      });
      _controller.clear();
    } catch (error) {
      // Handle error here, e.g., display an error message to the user
      print('Error sending message: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark theme background color
      appBar: AppBar(
        title: Text(
          "Yatri AI",
          style: Theme.of(context).textTheme.bodySmall, // Title text color
        ),
        backgroundColor: Colors.black, // App bar background color
        iconTheme: const IconThemeData(color: Colors.white), // Icon color
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _messages[index],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Message text color
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white), // Text field text color
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      hintStyle: TextStyle(color: Colors.grey), // Hint text color
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
