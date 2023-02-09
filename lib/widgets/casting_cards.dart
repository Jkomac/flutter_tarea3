// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {

final int idMovie;

  // Constructor
  const CastingCards({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getMovieCast(idMovie), //
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) { // Snapshot = datos devueltos por el getMovieCast()
        if (!snapshot.hasData){
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final casting = snapshot.data!;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              itemCount: casting.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => _CastCard(cast: casting[index])),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast cast;

  // Constructor
  const _CastCard({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
