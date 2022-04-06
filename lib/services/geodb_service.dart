import 'package:dio/dio.dart';
import 'package:tyba_flutter_challenge/models/export_models.dart';

class GeoDBService {
  GeoDBService();

  Future<List<City>> getCities() async {

    List<City> auxList = [];

    final dio = Dio();

    var uri = 'https://wft-geo-db.p.rapidapi.com/v1/geo/cities';

    var response = await dio.get(uri, queryParameters: {
      'params': {
        'limit': '10',
      }
    }, options: Options(
      headers: {
        'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
        'X-RapidAPI-Key': 'b7028bc75emsh3a5735790980900p1d074ejsnafdd60f7679d'
      }
    ));

    if(response.statusCode == 200) {
      for(Map<String, dynamic> element in response.data["data"]) {
        City city = City(
          name: element["name"],
          country: element["country"],
          countryCode: element["countryCode"],
          region: element["region"],
          regionCode: element["regionCode"],
          latitude: element["latitude"],
          longitude: element["longitude"]
        );

        auxList.add(city);
      }

    }

    return auxList;

  }
}