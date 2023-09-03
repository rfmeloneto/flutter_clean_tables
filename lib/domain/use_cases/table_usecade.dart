import 'package:table_app/data/repository/table_repository_implementation.dart';
import 'package:table_app/domain/entities/table_entities.dart';

class UseCaseGetAll {
  final TableRepositoryImplementation _tableRepository;
  UseCaseGetAll(this._tableRepository);

  List<TableEntities> useGetAll(){
    final list = _tableRepository
        .getAll('https://api.npoint.io/fac5d9952672f587e1c1');
    return list;
  }
}
