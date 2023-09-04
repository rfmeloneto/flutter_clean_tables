import '../../data/repository/table_repository_implementation.dart';
import '../../domain/entities/table_entities.dart';

class UseCaseGetAll {
  final TableRepositoryImplementation _tableRepository;
  UseCaseGetAll(this._tableRepository);

  Future<List<TableEntities>> useGetAll() async {
    final list = await _tableRepository
        .getAll('https://api.npoint.io/fac5d9952672f587e1c1');
    return list;
  }
}
