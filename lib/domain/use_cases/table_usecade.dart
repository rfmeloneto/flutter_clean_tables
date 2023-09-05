import '../../data/repository/table_repository_implementation.dart';
import '../../domain/entities/table_entities.dart';

class UseCaseGetAll {
  final TableRepositoryImplementation _tableRepository;
  UseCaseGetAll(this._tableRepository);

  Future<List<TableEntities>> useGetAll(String url) async {
    final list = await _tableRepository.getAll(url);
    return list;
  }

  Future<List<TableEntities>> useGetAllByYear(
      String url, int year, int month) async {
    final list = await _tableRepository.getAllByYearMonth(url, year, month);
    return list;
  }

  Future<Map<String, dynamic>> useGetByYearMonthPie(
      String url, int year, int month) async {
    final map = await _tableRepository.getByYearMonthPie(url, year, month);
    return map;
  }
}
