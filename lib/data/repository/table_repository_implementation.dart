import '../../domain/entities/table_entities.dart';
import '../../domain/repository_interfaces/table_repository_interface.dart';
import '../datasource/tables_datasource.dart';
import '../model/table_model.dart';

class TableRepositoryImplementation implements TableRepositoryInterface {
  final TableDataSource _tableDataSource;
  TableRepositoryImplementation(this._tableDataSource);

  @override
  Future<List<TableEntities>> getAll(String url) async {
    final response = await _tableDataSource.getFromApi(url);
    final table = TableModel.fromMapList(response);
    return table;
  }

  @override
  Future<List<TableEntities>> getAllByYear(String url, int year) async {
    List<TableEntities> filtered = [];
    var result = await _tableDataSource.getFromApi(url);
    var entities = TableModel.fromMapList(result);
    for (var item in entities) {
      if (item.year == year) {
        filtered.add(item);
      }
    }
    return filtered;
  }
}
