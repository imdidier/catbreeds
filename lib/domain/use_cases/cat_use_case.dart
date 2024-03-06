import '../../data/models/cat_model.dart';
import '../repositories/cat_repository.dart';

class CatUseCase {
  final CatRepository repository;

  CatUseCase({required this.repository});

  Future<List<CatModel>?> getListCat() => repository.getListCat();
}
