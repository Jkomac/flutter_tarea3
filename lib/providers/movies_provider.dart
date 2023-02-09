import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  // Atributos
  String _baseUrl = 'api.themoviedb.org'; // No hace falta todo se puede copiar el contenido tras https:// hasta el dominio principal
  String _apiKey = 'bdf025da16866f6d864b4124114642c2';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopular = [];

  Map<int, List<Cast>> casting = {}; // PeliculaID + Lista de Actores

  MoviesProvider() {
    print('Movies Provider inicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async { // Metodo encargado de hacer la peticion al servidor para obtener la info de las pelis
    print('getOnDisplayMovies');
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

  // Tarea 3
  getOnPopular(){}// getOnPopulars() async {} + consulta

  Future<List<Cast>> getMovieCast(int idMovie) async{
    print('Pedimos info al servidor');
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
