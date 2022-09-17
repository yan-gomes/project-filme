class Movies {
  int? id;
  double? voteAverage;
  String? title;
  String? posterUrl;
  List<String>? genres;
  String? releaseDate;

  Movies(
      {this.id,
      this.voteAverage,
      this.title,
      this.posterUrl,
      this.genres,
      this.releaseDate});

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voteAverage = json['vote_average'];
    title = json['title'];
    posterUrl = json['poster_url'];
    genres = json['genres'].cast<String>();
    releaseDate = json['release_date'];
  }
}
