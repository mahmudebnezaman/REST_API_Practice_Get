class GalleryModel {
  String? albumId;
  String? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  GalleryModel.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'].toString();
    id = json['id'].toString();
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}