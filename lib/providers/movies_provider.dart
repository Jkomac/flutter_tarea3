// ignore_for_file: unnecessary_this, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../models/models.dart';

/*
  Clase que se encarga de la extraccion de datos para dar funcionalidad a nuestra aplicacion
*/

class MoviesProvider extends ChangeNotifier {
  // Atributos
  String _baseUrl = 'api.themoviedb.org'; // No hace falta todo se puede copiar el contenido tras https:// hasta el dominio principal
  String _apiKey = 'bdf025da16866f6d864b4124114642c2';
  String _language = 'es-ES';
  String _page = '1';
  String _region = 'ES'; // Establecemos Espanya como valor de la region para el apartado de Populars

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopulars = [];

  Map<int, List<Cast>> casting = {}; // PeliculaID + Lista de Actores

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getOnPopulars();
  }

  // Metodo encargado de hacer la peticion al servidor para obtener la info de las pelis en el CardSwiper
  getOnDisplayMovies() async { 
    // (URL, Acceder al EndPoint, Definir conjunto Clave - Valor)
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page
    }); 

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results; // Iniciamos la variable con el listado de peliculas

    notifyListeners(); // Avisar a todo el arbol de Widgets que usan este provider de que ha habido cambios
  }

  // Metodo encargado de hacer la peticion al servidor para obtener la info de las pelis populares en el MovieSlider
  getOnPopulars() async {
    // (URL, Acceder al EndPoint, Definir conjunto Clave - Valor)
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _page,
      'region': _region
    });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final popularsResponse = PopularsResponse.fromJson(result.body);

    onPopulars = popularsResponse.results; // Iniciamos la variable con el listado de peliculas

    notifyListeners(); // Avisar a todo el arbol de Widgets que usan este provider de que ha habido cambios
  }

  // Metodo encargado de hacer la peticion al servidor para obtener las peliculas a ser buscadas
  Future<List<Movie>> searchMovies(String query) async{
    // (URL, Acceder al EndPoint, Definir conjunto Clave - Valor)
    var url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final searchResponse = SearchResponse.fromJson(result.body);

    return searchResponse.results;
  }

  // Metodo encargado de hacer la peticion al servidor para extraer los actores de una pelicula
  Future<List<Cast>> getMovieCast(int idMovie) async{
    // (URL, Acceder al EndPoint, Definir conjunto Clave - Valor)
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits', {
      'api_key': _apiKey,
      'language': _language
    }); 

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);
    final creditsResponse = CreditResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }
}
