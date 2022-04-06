import 'package:flutter/material.dart';
import 'package:tyba_flutter_challenge/models/export_models.dart';
import 'package:tyba_flutter_challenge/services/geodb_service.dart';

class GeoDBProvider extends ChangeNotifier {

  final GeoDBService _geoDBService = GeoDBService();

  List<City> _cities = [];

  List<City> getCities (){
    return _cities;
  }

  Future<void> populateCities() async {
    _cities = await _geoDBService.getCities();
  }

}