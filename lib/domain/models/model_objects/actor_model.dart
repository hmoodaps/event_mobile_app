class ActorModel {
  final int pageId;
  final String title;
  final String extract;
  final String imageSource;

  ActorModel({
    required this.pageId,
    required this.title,
    required this.extract,
    required this.imageSource,
  });

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    final page = json['query']['pages'].values.first;
    return ActorModel(
      pageId: page['pageid'],
      title: page['title'],
      extract: page['extract'],
      imageSource: page['original']['source'],
    );
  }
}
