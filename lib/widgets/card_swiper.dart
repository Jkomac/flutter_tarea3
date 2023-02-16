// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

/*
  Clase para reflejar el listado de peliculas de estreno (NowPlaying) en nuestra ventana principal (Parte superior)
*/

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  // Constructor
  const CardSwiper({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if(this.movies.isEmpty){
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
        width: double.infinity,
        // Aquest multiplicador estableix el tant per cent de pantalla ocupada 50%
        height: size.height * 0.5,
        // color: Colors.red,
        child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments: movie),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'), // Imagen de carga 
                    image: NetworkImage(movie.fullPosterPath),
                    fit: BoxFit.cover),
              ),
            );
          },
        ));
  }
}

// URL para visualizar portadas: https://image.tmdb.org/t/p/w500