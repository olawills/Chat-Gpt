import 'package:chat_gpt/exports/theme_exports.dart';
import 'package:chat_gpt/provider/chat_provider.dart';
import 'package:chat_gpt/provider/models_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'exports/screens_export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat GPT ',
        theme: AppTheme.appTheme,
        home: const ChatScreen(),
      ),
    );
  }
}
