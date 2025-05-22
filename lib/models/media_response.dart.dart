class MediaResponse {
  final String url;
  final String type; // "image" or "video"

  MediaResponse({required this.url, required this.type});

  factory MediaResponse.fromMap(Map<String, dynamic> map) {
    return MediaResponse(
      url: map['url'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type,
    };
  }
}
