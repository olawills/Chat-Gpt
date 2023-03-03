class AppModel {
  final String id;
  final int created;
  final String root;

  AppModel({
    required this.id,
    required this.created,
    required this.root,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: json['id'],
      created: json['created'],
      root: json['root'],
    );
  }
  static List<AppModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => AppModel.fromJson(data)).toList();
  }
}


