import 'dart:convert' show json;

import 'package:bhaav/firebaseauth/data_models/country.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart' show TextEditingController;

class CountryProvider with ChangeNotifier {
  CountryProvider() {
    searchController.addListener(_search);
  }

  List<Country> _countries = [];

  List<Country> get countries => _countries;

  List<Country> _searchResults = [];

  List<Country> get searchResults => _searchResults;

  set searchResults(List<Country> value) {
    _searchResults = value;
    print('SearchResults ${searchResults.length}');
    notifyListeners();
  }

  Country _selectedCountry = Country();

  Country get selectedCountry => _selectedCountry;

  set selectedCountry(Country value) {
    _selectedCountry = value;
    notifyListeners();
  }

  final TextEditingController _searchController = TextEditingController();

  TextEditingController get searchController => _searchController;

  void _search() {
    String query = searchController.text;
    print(query);
    if (query.length == 0 || query.length == 1) {
      searchResults = countries;
    } else {
      List<Country> _results = [];
      countries.forEach((Country c) {
        if (c.toString().toLowerCase().contains(query.toLowerCase()))
          _results.add(c);
      });
      searchResults = _results;
      print("results length: ${searchResults.length}");
//      print('added few countries based on search ${searchResults.length}');
    }
  }

  void resetSearch() {
    searchResults = countries;
  }
}
