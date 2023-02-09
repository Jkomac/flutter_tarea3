// To parse this JSON data, do
//
//     final creditResponse = creditResponseFromMap(jsonString);

import 'models.dart';

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
