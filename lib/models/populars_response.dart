import 'models.dart';

/*
  Clase para reflejar el listado de peliculas Populares resultantes de la extraccion de datos
*/

class PopularsResponse {
    PopularsResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory PopularsResponse.fromJson(String str) => PopularsResponse.fromMap(json.decode(str));

    factory PopularsResponse.fromMap(Map<String, dynamic> json) => PopularsResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}