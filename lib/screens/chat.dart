import 'package:chatlinc/widgets/chat_messages.dart';
import 'package:chatlinc/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Set up push notifications using Firebase Cloud Messaging (FCM)
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    // Request user permission for notifications
    await fcm.requestPermission();

    // Subscribe to the 'chat' topic to receive chat-related notifications
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    // Call the setupPushNotifications function during initialization
    setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        // Display the app title in the app bar
        actions: [
          IconButton(
            onPressed: () {
              // Log out the user when the exit button is pressed
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child:
                ChatMessages(), // Display chat messages in an expanded widget
          ),
          NewMessage(), // Display the new message input field
        ],
      ),
    );
  }
}
