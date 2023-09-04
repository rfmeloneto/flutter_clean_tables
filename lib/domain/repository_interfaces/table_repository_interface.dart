import "../entities/table_entities.dart";

abstract class TableRepositoryInterface {
  Future<List<TableEntities>> getAll(String url);
  // Future<List<TableEntities>> getAllByMonthYear(
  //     String url, int month, int year);
}
