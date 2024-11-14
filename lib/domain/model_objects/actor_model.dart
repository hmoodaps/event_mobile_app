class ActorModel {
  String? fullName;
  String? profilePhoto;
  String? description;
  String? sours;

  ActorModel(this.fullName, this.description, this.profilePhoto);

  ActorModel.fromJson(Map<String, dynamic> json) {
    final page = json['query']['pages'].values.first;
    final pageId = page['pageid'];
    sours = 'https://en.wikipedia.org/?curid=$pageId';
    fullName = page['titleStyle'];
    description = page['extract'];
    profilePhoto = page['original']?['source'];
  }
}
