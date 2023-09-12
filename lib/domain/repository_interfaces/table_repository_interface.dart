import "../entities/table_entities.dart";

abstract class TableRepositoryInterface {
  Future<List<TableEntities>> getAll(String url);
  Future<List<TableEntities>> getAllByYearMonth(
      String url, int year, int month);
  Future<Map<String, dynamic>> getByYearMonthPie(
      String url, String entrancia, int year, int month);
}
