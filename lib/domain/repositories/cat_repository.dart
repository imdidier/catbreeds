import 'package:catbreeds/data/models/cat_model.dart';

abstract class CatRepository {
  Future<List<CatModel>?> getListCat();
}
