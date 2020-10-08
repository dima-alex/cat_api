class Url {
  String url;
  int height;
  int width;

  Url({
    this.url,
    this.height,
    this.width,
  });

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      url: json['url'],
      height: json['height'],
      width: json['width'],
    );
  }
}
