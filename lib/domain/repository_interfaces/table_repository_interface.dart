import "../entities/table_entities.dart";

abstract class TableRepositoryInterface {
  Future<List<TableEntities>> getAll(String url);
  Future<List<TableEntities>> getAllByYear(String url, int year);
}
