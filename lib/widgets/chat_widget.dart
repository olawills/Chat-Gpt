import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/exports/theme_exports.dart';
import 'package:flutter/material.dart';
import '../exports/widget_exports.dart';

class ChatWidget extends StatelessWidget {
  final String message;
  final int chatIndex;
  const ChatWidget({Key? key, required this.message, required this.chatIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: chatIndex == 0 ? backgroundColor : bodyColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.chatLogo,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: chatIndex == 0
                      ? TextWidget(text: message)
                      : DefaultTextStyle(
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                message.trim(),
                              ),
                            ],
                          ),
                        ),
                ),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: textColor,
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: textColor,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
