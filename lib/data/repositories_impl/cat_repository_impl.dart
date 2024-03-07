import 'package:catbreeds/data/datasources/cat_datasource.dart';
import 'package:catbreeds/data/models/cat_model.dart';
import 'package:catbreeds/domain/repositories/cat_repository.dart';
import 'package:flutter/foundation.dart';

class CatRepositoryImpl implements CatRepository {
  final CatDatasourceImpl datasource;

  CatRepositoryImpl({required this.datasource});
  @override
  Future<List<CatModel>?> getListCat() async {
    try {
      final resp = await datasource.getListCat();
      if (resp == null) {
        if (kDebugMode) {
          print('Null value gotten');
        }
        return null;
      }
      return resp;
    } catch (e) {
      if (kDebugMode) {
        print('CatRepositoryImpl, getListCat, error: $e');
      }
      return null;
    }
  }
}
