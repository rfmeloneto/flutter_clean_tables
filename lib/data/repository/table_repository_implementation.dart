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
  Future<List<TableEntities>> getAllByYearMonth(
      String url, int year, int month) async {
    List<TableEntities> filtered = [];
    var result = await _tableDataSource.getFromApi(url);
    var entities = TableModel.fromMapList(result);
    for (var item in entities) {
      if (item.year == year && item.month == month) {
        filtered.add(item);
      }
    }
    return filtered;
  }

  @override
  Future<Map<String, dynamic>> getByYearMonthPie(
      String url, int year, int month) async {
    Map<String, dynamic> mapVagas = {};
    mapVagas['vagas'] = 0;
    mapVagas['ocupadas'] = 0;
    mapVagas['total'] = 0;
    var result = await _tableDataSource.getFromApi(url);
    var entities = TableModel.fromMapList(result);
    for (var item in entities) {
      if (item.year == year && item.month == month) {
        mapVagas['vagas'] += item.vacantPositions;
        mapVagas['ocupadas'] += item.occupiedPositions;
        mapVagas['total'] += item.totalPositions;
      }
    }
    print(mapVagas['vagas']);
    return mapVagas;
  }
}
