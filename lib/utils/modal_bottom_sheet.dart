import 'package:chat_gpt/exports/theme_exports.dart';
import 'package:chat_gpt/widgets/drop_down.dart';
import 'package:chat_gpt/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showBottomSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        backgroundColor: backgroundColor,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                  child: TextWidget(
                    text: 'Choosen Model',
                    fontSize: 16,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ModelDropDownWidget(),
                )
              ],
            ),
          );
        });
  }
}
