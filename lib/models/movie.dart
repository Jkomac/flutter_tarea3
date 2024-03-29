import 'models.dart';

class Movie {
    Movie({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath; // Puesto el Null Safety por si alguna pelicula no tiene imagen de portada
    DateTime? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    // Getters
    get fullPosterPath{
      if(this.posterPath != null){
        return 'https://image.tmdb.org/t/p/w500${posterPath}'; // Forma para obtener la portada al incluir la URL
      }
      return 'https://i.stack.imgur.com/GNhxO.png'; // Imagen por defecto (Icono blando + Fondo gris)
    }

    get fullBackdropPath{
      if(this.backdropPath != null){
        return 'https://image.tmdb.org/t/p/w500${backdropPath}'; // Portada de fondo horizontal
      }
      return 'https://i.stack.imgur.com/GNhxO.png';
    }

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );
}
