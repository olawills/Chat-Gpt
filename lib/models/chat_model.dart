class ChatModel {
  final String text;
  final int index;
 // final String finishReason;

  ChatModel({
    required this.text,
    required this.index,
   // required this.finishReason,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      text: json['text'],
      index: json['index'],
      // finishReason: json['finish_reason'],
    );
  }
}