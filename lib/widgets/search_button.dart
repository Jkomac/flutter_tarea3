// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

/*
  Clase para reflejar el listado de peliculas resultantes a la hora hacer una busqueda por nombre de la pelicula
*/

class CustomeSearch extends SearchDelegate{

  final List<String> matchQuery = [];
  List<Movie> movies = [];

  @override
  // Boton para resetear la consulta
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  //  Boton para volver atrás
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  // Boton que muestra los resultados segun la consulta (Lupa del teclado)
  Widget buildResults(BuildContext context) {
    for (Movie m in movies) {
      if (m.originalTitle.toLowerCase().contains(query.toLowerCase())) {
        return buildSuggestions(context);
      }
    }
    return Center( // En caso de que no coincidan los resultados, mostrara el siguiente texto
      child: Text('No se han encontrado resultados :(', style: TextStyle(fontWeight: FontWeight.w800)),
    );
  }

  @override
  // Listado de peliculas a mostrar
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
        if(!snapshot.hasData){
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        movies = snapshot.data!;

        for (Movie m in movies) {
          if (m.originalTitle.toLowerCase().contains(query.toLowerCase())) {
            matchQuery.add(m.title);
          }
        }
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(movies[index].originalTitle),
                onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: movies[index]),
              );
            },
        );
      }
    );
  }
}