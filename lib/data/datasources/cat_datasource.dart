import 'package:catbreeds/data/models/cat_model.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

abstract class CatDatasource {
  Future<List<CatModel>?> getListCat();
}

class CatDatasourceImpl implements CatDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.thecatapi.com/v1/',
      headers: {
        'x-api-key': 'bda53789-d59e-46cd-9bc4-2936630fde39',
      },
    ),
  );
  @override
  Future<List<CatModel>?> getListCat() async {
    try {
      final response = await dio.get(
        'breeds',
      );
      if (response.statusCode != 200) {
        return null;
      }
      return List.from(
        response.data.map(
          (cat) => CatModel.fromJson(cat),
        ),
      );
    } catch (e) {
      if (kDebugMode) print('BreedDatasourceImpl, getListCat, error: $e');
      return null;
    }
  }
}
