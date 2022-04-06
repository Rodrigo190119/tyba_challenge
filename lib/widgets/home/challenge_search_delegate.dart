import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyba_flutter_challenge/models/export_models.dart';
import 'package:tyba_flutter_challenge/providers/export_providers.dart';

class ChallengeSearchDelegate extends SearchDelegate<City> {

  List<City> cities = [];

  List<City> _filter = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(cities[index].name!),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    cities = Provider.of<GeoDBProvider>(context, listen: false).getCities();

    _filter = cities.where((element){
      return element.name!.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: _filter.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(cities[index].name!),
        );
      }

    );
  }

}