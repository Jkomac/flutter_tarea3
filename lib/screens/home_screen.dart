import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

/*
  Ventana principal de la aplicacion
*/

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () { // Funcion del boton de busqueda
              showSearch(
                context: context,
                delegate: CustomeSearch()
              );
            },
            icon: const Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              // Slider de pel·licules
              MovieSlider(movies: moviesProvider.onPopulars),
            ],
          ),
        ),
      ),
    );
  }
}