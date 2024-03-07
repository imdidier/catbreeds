import 'package:catbreeds/data/datasources/cat_datasource.dart';
import 'package:catbreeds/data/repositories_impl/cat_repository_impl.dart';
import 'package:catbreeds/domain/use_cases/cat_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/models/cat_model.dart';

class CatProvider with ChangeNotifier {
  String baseUrl = 'https://cdn2.thecatapi.com/images/';
  List<CatModel> cats = [];
  List<CatModel> filteredCats = [];
  CatRepositoryImpl repository =
      CatRepositoryImpl(datasource: CatDatasourceImpl());
  TextEditingController breedController = TextEditingController();
  String auxName = '';
  List<String> detailsToShow = [
    'Description',
    'Origin',
    'Alt names',
    'Temperament',
    'Energy level',
    'Affection level',
    'Intelligence',
    'Dog friendly',
    'Child friendly',
    'Adaptability',
    'Life span',
  ];

  Future<bool> getListCat() async {
    try {
      final resp = await CatUseCase(repository: repository).getListCat();
      if (resp == null) return false;
      cats = resp;
      filteredCats = [...cats];
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('CatProvider, getListCat, error: $e');
      }
      return false;
    }
  }

  void filterCatsByBreed(String query) {
    try {
      filteredCats.clear();
      if (query.isEmpty) {
        filteredCats = [...cats];
      } else {
        for (CatModel cat in cats) {
          if (cat.name.toLowerCase().contains(query.toLowerCase())) {
            filteredCats.add(cat);
          }
        }
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('CatProvider, filterCatsByBreed, error: $e');
      }
    }
  }
}
