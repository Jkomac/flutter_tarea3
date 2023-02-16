import 'models.dart';

/*
  Clase para reflejar el listado de actores/actrices resultantes de la extraccion de datos sobre una pelicula
*/

class CreditResponse {
    CreditResponse({
        required this.id,
        required this.cast,
    });

    int id;
    List<Cast> cast;

    factory CreditResponse.fromJson(String str) => CreditResponse.fromMap(json.decode(str));


    factory CreditResponse.fromMap(Map<String, dynamic> json) => CreditResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
    );
}
