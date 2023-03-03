import 'package:chat_gpt/exports/theme_exports.dart';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../exports/models_export.dart';
import '../exports/widget_exports.dart';
import '../provider/models_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController _scrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    _scrollController = ScrollController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.openAiLogo,
          ),
        ),
        title: Text(
          'ChatGPT',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showBottomSheet(context: context);
            },
            icon: Icon(
              Icons.more_vert_rounded,
              color: textColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: chatProvider.getChatList.length, //chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    message: chatProvider
                        .getChatList[index].text, //chatList[index].text,
                    chatIndex: chatProvider
                        .getChatList[index].index, //chatList[index].index,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              SpinKitThreeBounce(
                color: textColor,
                size: 18,
              ),
            ],
            const SizedBox(height: 15),
            ColoredBox(
              color: bodyColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextField(
                          focusNode: focusNode,
                          enableInteractiveSelection: true,
                          style: TextStyle(
                            color: textColor,
                          ),
                          controller: textEditingController,
                          onSubmitted: (value) async {
                            await sendMesaage(
                                modelsProvider: modelsProvider,
                                chatProvider: chatProvider);
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'How can i help you',
                            hintStyle: TextStyle(
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMesaage(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      icon: Icon(
                        Icons.send,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  Future<void> sendMesaage(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(
          text: 'wait for the previous message to load',
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(
          text: 'Type a message',
        ),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserMsg(msg: msg);
        // chatList.add(
        //   ChatModel(
        //     text: textEditingController.text,
        //     index: 0,
        //   ),
        // );
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMsgAndGetAnswer(
        msg: msg,
        chosedModelid: modelsProvider.getCurrentModel,
      );

      // chatList.addAll(await ApiServices.getChatModel(
      //   message: textEditingController.text,
      //   modelId: modelsProvider.getCurrentModel,
      // ));
      setState(() {});
    } catch (error) {
      // print('error $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            text: error.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isTyping = false;
        scrollListToEnd();
      });
    }
  }
}
